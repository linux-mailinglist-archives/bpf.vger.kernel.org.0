Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8B22AC4BC
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 20:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbgKITLH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 14:11:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbgKITLH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 14:11:07 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B55206D8;
        Mon,  9 Nov 2020 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604949066;
        bh=UVgQldwg+UY2jgndCdRMqklrY1C548QWXrVvtULaecE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqXDyHLnt5rdJr4DBmK94lmYoKU3K7JmAveSaUMyZqlgygAkVDKVN6RLglWZhYs7A
         y9XyLn9sVIvdter+Q7gFtQPnOHHGE9psxbo3lPrU8KFj90t+gcjNWt1SRygWGHvnuq
         jdGrNUf6/o+LHBRfQ3tfMd4D/isdd25yfhlFG7DQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4F191411D1; Mon,  9 Nov 2020 16:11:04 -0300 (-03)
Date:   Mon, 9 Nov 2020 16:11:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCHv4 0/3] pahole/kernel: Workaround dwarf bug for function
 encoding
Message-ID: <20201109191104.GA342737@kernel.org>
References: <20201106222512.52454-1-jolsa@kernel.org>
 <CAEf4BzZXOyA0gROk2=G1R+m7gHcqTZHpE9L2G_EBCZET3FpzAw@mail.gmail.com>
 <20201109172911.GA340169@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109172911.GA340169@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Nov 09, 2020 at 02:29:11PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 06, 2020 at 02:56:45PM -0800, Andrii Nakryiko escreveu:
> > On Fri, Nov 6, 2020 at 2:25 PM Jiri Olsa <jolsa@kernel.org> wrote:
>  
> > For the series:
>  
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Thanks, applied, testing now.

Now we have:

$ pfunct -F btf /sys/kernel/btf/vmlinux  | wc -l
38816
$ pfunct -F btf /sys/kernel/btf/vmlinux  | head
get_e820_md5
relocate_restore_code
resume_play_dead
bsp_pm_callback
msr_initialize_bdw
msr_save_cpuid_features
pm_check_save_msr
amd_bus_cpu_online
update_res
pci_read
$

$ pfunct -F btf /sys/kernel/btf/vmlinux -f msr_save_cpuid_features
int msr_save_cpuid_features(const struct x86_cpu_id  * c);
$
$ pfunct -F btf /sys/kernel/btf/vmlinux -f tcp_v4_rcv
int tcp_v4_rcv(struct sk_buff * skb);
$

[acme@five ~]$ pfunct -F btf /sys/kernel/btf/vmlinux --class=sk_buff | head
pskb_expand_head
skb_put
audit_list_rules_send
netlink_ack
consume_skb
skb_queue_head
skb_queue_tail
netlink_broadcast
__nlmsg_put
kfree_skb
[acme@five ~]$ pfunct -F btf /sys/kernel/btf/vmlinux -f audit_list_rules_send
int audit_list_rules_send(struct sk_buff * request_skb, int seq);
[acme@five ~]$ pfunct -F btf /sys/kernel/btf/vmlinux -f netlink_broadcast
int netlink_broadcast(struct sock * ssk, struct sk_buff * skb, __u32 portid, __u32 group, gfp_t allocation);
[acme@five ~]$

Seems to work :-)

In a future version I'll make it work with btf and
/sys/kernel/btf/vmlinux by default if only function names are provided,
like pahole with types:

[acme@five ~]$ pahole sk_buff_head
struct sk_buff_head {
	struct sk_buff *           next;                 /*     0     8 */
	struct sk_buff *           prev;                 /*     8     8 */
	__u32                      qlen;                 /*    16     4 */
	spinlock_t                 lock;                 /*    20     4 */

	/* size: 24, cachelines: 1, members: 4 */
	/* last cacheline: 24 bytes */
};
[acme@five ~]$ pahole list_head
struct list_head {
	struct list_head *         next;                 /*     0     8 */
	struct list_head *         prev;                 /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* last cacheline: 16 bytes */
};
[acme@five ~]$

Pushed out.

- Arnaldo

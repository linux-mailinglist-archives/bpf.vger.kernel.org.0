Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA49288BDF
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 16:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388208AbgJIOxr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 10:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732056AbgJIOxr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 10:53:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCBA422260;
        Fri,  9 Oct 2020 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602255226;
        bh=DQLk9PN+dno5Fhjh4xfRjPofKWTcubzhYk45CbiUU+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JpAT3YyJvZyji3Zdb1So24yyOBXaY6kJsq5yNKiUDeg0IoQjaH4fNq3YlzyWRzm5h
         zjNcN0AbF9fPlGWlNsv3egGI+9FxHXGjIJPFc+4duTZuInS21ycl+IPL4ug/NoWdbr
         8Odv07o92vvcXEhhqN1iVEqnuITcgnA22qQkfiE8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 69215403AC; Fri,  9 Oct 2020 11:53:43 -0300 (-03)
Date:   Fri, 9 Oct 2020 11:53:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH v2 dwarves 1/8] btf_loader: use libbpf to load BTF
Message-ID: <20201009145343.GA322246@kernel.org>
References: <20201008234000.740660-1-andrii@kernel.org>
 <20201008234000.740660-2-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008234000.740660-2-andrii@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Oct 08, 2020 at 04:39:53PM -0700, Andrii Nakryiko escreveu:
> From: Andrii Nakryiko <andriin@fb.com>
> 
> Switch BTF loading to completely use libbpf's own struct btf and related APIs.
> BTF encoding is still happening with pahole's own code, so these two code
> paths are not sharing anything now. String fetching is happening based on
> whether btfe->strings were set to non-NULL pointer by btf_encoder.

While testing this one I noticed a problem, but it isn't caused by this
particular patch:

[acme@five pahole]$ cp ~/git/build/v5.9-rc6+/net/ipv4/tcp_ipv4.o .
[acme@five pahole]$ readelf -SW tcp_ipv4.o | grep BTF
[acme@five pahole]$ pahole -J tcp_ipv4.o
[acme@five pahole]$ readelf -SW tcp_ipv4.o | grep BTF
  [105] .BTF              PROGBITS        0000000000000000 0fbb3c 03f697 00      0   0  1
[acme@five pahole]$ ./btfdiff tcp_ipv4.o
--- /tmp/btfdiff.dwarf.BDAvGi	2020-10-09 11:41:45.161509391 -0300
+++ /tmp/btfdiff.btf.p81icw	2020-10-09 11:41:45.177509720 -0300
@@ -4056,7 +4056,7 @@ struct tcp_congestion_ops {
 	u32                        (*min_tso_segs)(struct sock *); /*    96     8 */
 	u32                        (*sndbuf_expand)(struct sock *); /*   104     8 */
 	void                       (*cong_control)(struct sock *, const struct rate_sample  *); /*   112     8 */
-	size_t                     (*get_info)(struct sock *, u32, int *, union tcp_cc_info *); /*   120     8 */
+	size_t                     (*get_info)(struct sock *, u32, int *, struct tcp_cc_info *); /*   120     8 */
 	/* --- cacheline 2 boundary (128 bytes) --- */
 	char                       name[16];             /*   128    16 */
 	struct module *            owner;                /*   144     8 */
[acme@five pahole]$ git log --oneline -5
ef4f971a9cf745fc (HEAD) dwarf_loader: Conditionally define DW_AT_alignment
cc3f9dce3378280f pahole: Implement --packed
08f49262f474370a man-pages: Fix 'coimbine' typo
fdc639188cb514e4 (tag: v1.18) dwarves: Prep v1.18
70c3e669709b6351 spec: Set the build type to 'Release'
[acme@five pahole]$

And looking at the source code it is a union:

include/net/tcp.h

        size_t (*get_info)(struct sock *sk, u32 ext, int *attr,
                           union tcp_cc_info *info);


So this tcp_cc_info isn't available in DWARF and thus isn't available in
the resulting BTF:

[acme@five pahole]$ pahole -F dwarf -C tcp_cc_info tcp_ipv4.o
pahole: type 'tcp_cc_info' not found
[acme@five pahole]$ pahole -F btf -C tcp_cc_info tcp_ipv4.o
pahole: type 'tcp_cc_info' not found
[acme@five pahole]$


If you look at /sys/kernel/btf/vmlinux it is there:

[acme@five pahole]$ pahole tcp_cc_info
union tcp_cc_info {
	struct tcpvegas_info       vegas;              /*     0    16 */
	struct tcp_dctcp_info      dctcp;              /*     0    16 */
	struct tcp_bbr_info        bbr;                /*     0    20 */
};
[acme@five pahole]$

I.e. when encoding vmlinux we're good and for the BTF use case so far
this is thus not a problem, will continue processing your patches and
then later try to figure this out.

For completeness when looking at tcp_congestion_ops using
/sys/kernel/btf/vmlinux, all is ok:

[acme@five pahole]$ pahole tcp_congestion_ops
struct tcp_congestion_ops {
	struct list_head           list;                 /*     0    16 */
	u32                        key;                  /*    16     4 */
	u32                        flags;                /*    20     4 */
	void                       (*init)(struct sock *); /*    24     8 */
	void                       (*release)(struct sock *); /*    32     8 */
	u32                        (*ssthresh)(struct sock *); /*    40     8 */
	void                       (*cong_avoid)(struct sock *, u32, u32); /*    48     8 */
	void                       (*set_state)(struct sock *, u8); /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	void                       (*cwnd_event)(struct sock *, enum tcp_ca_event); /*    64     8 */
	void                       (*in_ack_event)(struct sock *, u32); /*    72     8 */
	u32                        (*undo_cwnd)(struct sock *); /*    80     8 */
	void                       (*pkts_acked)(struct sock *, const struct ack_sample  *); /*    88     8 */
	u32                        (*min_tso_segs)(struct sock *); /*    96     8 */
	u32                        (*sndbuf_expand)(struct sock *); /*   104     8 */
	void                       (*cong_control)(struct sock *, const struct rate_sample  *); /*   112     8 */
	size_t                     (*get_info)(struct sock *, u32, int *, union tcp_cc_info *); /*   120     8 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	char                       name[16];             /*   128    16 */
	struct module *            owner;                /*   144     8 */

	/* size: 152, cachelines: 3, members: 18 */
	/* last cacheline: 24 bytes */
};
[acme@five pahole]$

And a btfdiff on vmlinux also shows BTF and DWARF produce the same
results:

[acme@five pahole]$ cp ~/git/build/bpf-next-v5.9.0-rc8+/vmlinux .
[acme@five pahole]$ readelf -SW vmlinux  | grep BTF
  [24] .BTF              PROGBITS        ffffffff82494ac0 1694ac0 340207 00   A  0   0  1
  [25] .BTF_ids          PROGBITS        ffffffff827d4cc8 19d4cc8 0000a4 00   A  0   0  1
[acme@five pahole]$ ./btfdiff vmlinux
[acme@five pahole]$

- Arnaldo

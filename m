Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 649DF11ED85
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 23:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfLMWGC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 17:06:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41591 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMWGC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Dec 2019 17:06:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id s18so2183059pfd.8
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 14:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hEnsqcIZ0eIwGNsnG2ZPYZwINWOIroD6hOLK95Nap5Q=;
        b=JbT/yGJ5Wz/VuyMapR37jt46caZhfs61n3GC6dJv4cmdGW0DDTFLvrg8x2rPrEqxCv
         ecbAF+oRA1q5NW0ePvb+lFpLqDMeMT9EyEBD/3YcXlQ9E59Tph+NYLSHhb7BDRoIjtJ4
         yaqnuDgmNtBGd6OWvyHJlp491uKBpV/DX/jPEhCin463zlQ86uNrCsMZprP10uz+wKT0
         Noy1riynb897yAxojrtJnjck9YHPkzv52O5LUSUXQRY6/ZIBWHhfILNncnFFWoJPq2C0
         OvHET4NcHTXXYgsZU/M6pO0/6JdlXAgjmetytMdbFkifGDuKi6THmUntoooAJSe8TUDY
         97EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hEnsqcIZ0eIwGNsnG2ZPYZwINWOIroD6hOLK95Nap5Q=;
        b=rAtsLgfvPWdOoAUnm1s8t4O4mnt0HW2hHKTKnOQFAGEGniVUe2p0BXf0XsYhgMm8Qo
         GZEoyoIOiIXz6dSKhqv2yedYvqkkEjhScISvjP96pv0cviiuDhU+xbd9GWrXOnW8hQL4
         nPetB6bP7EX0RZy0wG4DYKT6g9W3gufu9LMmkGDAeamqXncw3LePoM+ynUQgRLhF17NE
         WLCWO5GETk8bK+vVLv8V0Lv+IjiVNHzsGoCUQbl8sfDjDeVK6+CVmQdlhRLpqEQag8hi
         npvxGbu7vrsBaimKfx7Wk+Cw5vM1YviesFR5OrUutpnNxVSPHK5qFhxb9ETF0vqw8+5X
         v3eQ==
X-Gm-Message-State: APjAAAXsKUnZpKFnP+6Ay3MLdX6HQ//F9ACUd3Uy6WqAwHVBQbx+RfEf
        6p6v3792BRForh3BGfl4rgbC7g==
X-Google-Smtp-Source: APXvYqyspd7ewpH8aRNYYYZLe5EUIPSzPBXUTHX764oSrU9mI3AHZT4P57mzn4ZvverqX5wF/TCqPA==
X-Received: by 2002:a62:aa09:: with SMTP id e9mr1941243pff.154.1576274761631;
        Fri, 13 Dec 2019 14:06:01 -0800 (PST)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id e4sm13075295pfj.125.2019.12.13.14.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 14:06:01 -0800 (PST)
Date:   Fri, 13 Dec 2019 14:06:00 -0800
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/2] bpf: expose __sk_buff wire_len/gso_segs to
 BPF_PROG_TEST_RUN
Message-ID: <20191213220600.GQ3105713@mini-arch>
References: <20191211175349.245622-1-sdf@google.com>
 <CAADnVQLAShTWUDaMd26cCP-na=U_ZVUBuWaXR7-VGV=H6r_Qbg@mail.gmail.com>
 <20191213212322.GP3105713@mini-arch>
 <CAADnVQKB+JafsQT4qjgECc1WzhoRvisO86NfS3D5-v-OYW5KgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKB+JafsQT4qjgECc1WzhoRvisO86NfS3D5-v-OYW5KgQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/13, Alexei Starovoitov wrote:
> On Fri, Dec 13, 2019 at 1:23 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > On 12/13, Alexei Starovoitov wrote:
> > > On Wed, Dec 11, 2019 at 9:53 AM Stanislav Fomichev <sdf@google.com> wrote:
> > > >
> > > > wire_len should not be less than real len and is capped by GSO_MAX_SIZE.
> > > > gso_segs is capped by GSO_MAX_SEGS.
> > > >
> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > >
> > > This change breaks tests:
> > > ./test_progs -n 16
> > > test_kfree_skb:PASS:prog_load sched cls 0 nsec
> > > test_kfree_skb:PASS:prog_load raw tp 0 nsec
> > > test_kfree_skb:PASS:find_prog 0 nsec
> > > test_kfree_skb:PASS:find_prog 0 nsec
> > > test_kfree_skb:PASS:find_prog 0 nsec
> > > test_kfree_skb:PASS:find global data 0 nsec
> > > test_kfree_skb:PASS:attach_raw_tp 0 nsec
> > > test_kfree_skb:PASS:attach fentry 0 nsec
> > > test_kfree_skb:PASS:attach fexit 0 nsec
> > > test_kfree_skb:PASS:find_perf_buf_map 0 nsec
> > > test_kfree_skb:PASS:perf_buf__new 0 nsec
> > > test_kfree_skb:FAIL:ipv6 err -1 errno 22 retval 0 duration 0
> > > on_sample:PASS:check_size 0 nsec
> > > on_sample:PASS:check_meta_ifindex 0 nsec
> > > on_sample:PASS:check_cb8_0 0 nsec
> > > on_sample:PASS:check_cb32_0 0 nsec
> > > on_sample:PASS:check_eth 0 nsec
> > > on_sample:PASS:check_ip 0 nsec
> > > on_sample:PASS:check_tcp 0 nsec
> > > test_kfree_skb:PASS:perf_buffer__poll 0 nsec
> > > test_kfree_skb:PASS:get_result 0 nsec
> > > #16 kfree_skb:FAIL
> > > Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
> > Ugh, it's probably because of '__skb->wire_len < skb->len' check.
> > Let me take a look.
> >
> > (sorry, I'm still not running/looking at full test_progs because BTF support
> > is WIP in our toolchain and some subtests fail because of that,
> > generating a bunch of noise).
> 
> I thought all bpf-next developers are developing against that tree ?
I am developing against that tree, but I have a wrapper around
make that points it to the proper version of cc/tools that we
use for prod builds (for consistency).

> Are you saying you cannot install the latest clang/pahole on your
> development system?
> git pull llvm;ninja;ninja install;
> git pull pahole; cmake;make
> why is it not possible?
Yeah, I'll do that now, it just requires some manual movements :-)

> Now your complains about skeleton make more sense,
> but it's an issue with your particular setup.
> 
> Anyway I'm not sure that this test issue is actually an issue with your patch.
> It could be that this test is flaky in a weird way. Just with and without your
> kernel patch it's 100% reproducible for me and I need to keep the rest
> of the patches
> moving without introducing failures in my test setup.
> All that will get resolved when we have kernel CI.
No, I'm pretty sure that's that wire_len check. I think I need to add
a special case to set it to skb->len if it's zero.
Will follow up with a v2!

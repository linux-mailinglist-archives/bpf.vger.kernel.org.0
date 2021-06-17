Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648223AB5B6
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 16:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhFQOVT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 10:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhFQOVT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 10:21:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCABC061574
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 07:19:11 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g4so3890348pjk.0
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=/1UczQSLpDCUUWa43iLedI3l8nkc2dHNA+5NemDu+Z4=;
        b=BIffTftdHAl31gIE2xi6S5mMLN+ejIimeAI0usFQoYefeFxWmPWQUn7DZYCyBbf69I
         TbdDcv6t3EFzvjjwXsPGoERvZZSFLLKCjErM+vcppNG0uj+ptWbWbsCwdMej89CFx9Tc
         uPHKPrj9C9nCIuPQTHfLhJ6PAAMHwjVAIGy97gWnYB+9AWZwG+p9DHiisC2nv7yupILq
         z9+MWFg56yfje2Y2k3wLL+3EbTP8T763oltp0fOdVOw0rqU3DynfxbdbCkb/2HkUkm/D
         TiYUYD/1Ll4zoGnutFWmOWfWlA2EjFm4Xkc2svOLV6ZMcb3YoNseTBG7qkhQ4P5O1n1/
         sX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/1UczQSLpDCUUWa43iLedI3l8nkc2dHNA+5NemDu+Z4=;
        b=hh/t/b6wEbImQVFjQIY6OZa62ZDYvxL9s/8q8Y6ejd3FtbUxgQLkkZZ2npXd2Xmkek
         pBmr9EWrcdPr0ZjAzcdnFhypjv9gT9cY70XG2tj5AL6lfUYjdS1R/G/GYbRj2+D5B+Kz
         hznNe5LJNEkbdPfMlPm9M2S0vJbP3VLxpuJTdf7BFXxcsa1Zk75G58B1rU17JsvPiHNv
         oEFPMyjrfWzpQ8f/n3ccj/ut+r0kASp9QdLSVYy6sicth3sDuH8aixCWs6IBbPX9Mrxf
         w4EwvhRIFpK9nwxHkXyA2RGKpKrEjybd3rIJvXM5CiLfyERei+wScTvQLF10VPYw0v2i
         HwQg==
X-Gm-Message-State: AOAM53197zSnEDPrs138QyRL869ErHdQNn17Zvc0nagkF6wOsz7WyUCc
        ijRfMMFCxrOwbN19VdYG3AlY3emR1AA=
X-Google-Smtp-Source: ABdhPJz5UDENJPv7NyAoZFjrpJXoGyRKcwUvIBP+K5tuHqQL3+mXZVF+KFjHg5/6bYr00TK+FQIzeQ==
X-Received: by 2002:a17:90a:10c8:: with SMTP id b8mr16838830pje.147.1623939551047;
        Thu, 17 Jun 2021 07:19:11 -0700 (PDT)
Received: from sea-l-00029082.olympus.f5net.com (d66-183-43-174.bchsia.telus.net. [66.183.43.174])
        by smtp.gmail.com with ESMTPSA id g8sm5482613pfu.177.2021.06.17.07.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 07:19:10 -0700 (PDT)
From:   Vincent Li <vincent.mc.li@gmail.com>
X-Google-Original-From: Vincent Li <vli@gmail.com>
Date:   Thu, 17 Jun 2021 07:19:08 -0700 (PDT)
To:     Yonghong Song <yhs@fb.com>
cc:     Vincent Li <vincent.mc.li@gmail.com>, bpf@vger.kernel.org
Subject: Re: R1 invalid mem access 'inv'
In-Reply-To: <92121d33-4a45-b27a-e3cd-e54232924583@fb.com>
Message-ID: <79e4924c-e581-47dd-875c-6fd72e85dfac@gmail.com>
References: <c43bc0a9-9eca-44df-d0c7-7865f448cc24@gmail.com> <92121d33-4a45-b27a-e3cd-e54232924583@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi Song,

Thank you for your response!


On Wed, 16 Jun 2021, Yonghong Song wrote:

> 
> 
> On 6/16/21 5:05 PM, Vincent Li wrote:
> > Hi BPF Experts,
> > 
> > I had a problem that verifier report "R1 invalid mem access 'inv'" when
> > I attempted to rewrite packet destination ethernet MAC address in Cilium
> > tunnel mode, I opened an issue
> > with detail here https://github.com/cilium/cilium/issues/16571:
> > 
> > I have couple of questions in general to try to understand the compiler,
> > BPF byte code, and the verifier.
> > 
> > 1 Why the BPF byte code changes so much with my simple C code change
> > 
> > a: BPF byte code  before C code change:
> > 
> > 0000000000006068 <LBB12_410>:
> >      3085:       bf a2 00 00 00 00 00 00 r2 = r10
> > ;       tunnel = map_lookup_elem(&TUNNEL_MAP, key);
> >      3086:       07 02 00 00 78 ff ff ff r2 += -136
> >      3087:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> >      3089:       85 00 00 00 01 00 00 00 call 1
> > ;       if (!tunnel)
> >      3090:       15 00 06 01 00 00 00 00 if r0 == 0 goto +262 <LBB12_441>
> > ;       key.tunnel_id = seclabel;
> >      3091:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0 ll
> >      3093:       67 02 00 00 20 00 00 00 r2 <<= 32
> >      3094:       77 02 00 00 20 00 00 00 r2 >>= 32
> >      3095:       b7 01 00 00 06 00 00 00 r1 = 6
> >      3096:       15 02 02 00 01 00 00 00 if r2 == 1 goto +2 <LBB12_413>
> >      3097:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> > 
> > 00000000000060d8 <LBB12_413>:
> > ;       return __encap_and_redirect_with_nodeid(ctx, tunnel->ip4,
> > seclabel, monitor);
> > 
> > 
> > b: BPF byte code  after C code change:
> > 
> > the C code diff change:
> > 
> > diff --git a/bpf/lib/encap.h b/bpf/lib/encap.h
> > index dfd87bd82..19199429d 100644
> > --- a/bpf/lib/encap.h
> > +++ b/bpf/lib/encap.h
> > @@ -187,6 +187,8 @@ encap_and_redirect_lxc(struct __ctx_buff *ctx, __u32
> > tunnel_endpoint,
> >                         struct endpoint_key *key, __u32 seclabel, __u32
> > monitor)
> >   {
> >          struct endpoint_key *tunnel;
> > +#define VTEP_MAC  { .addr = { 0xce, 0x72, 0xa7, 0x03, 0x88, 0x58 } }
> > +       union macaddr vtep_mac = VTEP_MAC;
> >            if (tunnel_endpoint) {
> >   #ifdef ENABLE_IPSEC
> > @@ -221,6 +223,8 @@ encap_and_redirect_lxc(struct __ctx_buff *ctx, __u32
> > tunnel_endpoint,
> >                                                  seclabel);
> >          }
> >   #endif
> > +       if (eth_store_daddr(ctx, (__u8 *) &vtep_mac.addr, 0) < 0)
> > +               return DROP_WRITE_ERROR;
> >          return __encap_and_redirect_with_nodeid(ctx, tunnel->ip4,
> > seclabel, monitor);
> >   }
> > 
> > the result BPF byte code
> > 
> > 0000000000004468 <LBB3_274>:
> >      2189:       bf a2 00 00 00 00 00 00 r2 = r10
> > ;       tunnel = map_lookup_elem(&TUNNEL_MAP, key);
> >      2190:       07 02 00 00 50 ff ff ff r2 += -176
> >      2191:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> >      2193:       85 00 00 00 01 00 00 00 call 1
> >      2194:       bf 07 00 00 00 00 00 00 r7 = r0
> >      2195:       79 a6 48 ff 00 00 00 00 r6 = *(u64 *)(r10 - 184)
> > ;       if (!tunnel)
> >      2196:       55 07 94 00 00 00 00 00 if r7 != 0 goto +148 <LBB3_289>
> > 
> > 00000000000044a8 <LBB3_275>:
> > ;       __u8 new_ttl, ttl = ip4->ttl;
> >      2197:       79 a1 38 ff 00 00 00 00 r1 = *(u64 *)(r10 - 200)
> >      2198:       71 13 16 00 00 00 00 00 r3 = *(u8 *)(r1 + 22)
> > ;       if (ttl <= 1)
> >      2199:       25 03 01 00 01 00 00 00 if r3 > 1 goto +1 <LBB3_277>
> >      2200:       05 00 20 ff 00 00 00 00 goto -224 <LBB3_253>
> > 
> > 
> > You can see that:
> > 
> > before change:  <LBB12_410>
> > after change    <LBB3_274>
> > 
> > is different that <LBB12_410> has instructions 3091, 3092... but
> > <LBB3_274> end with instruction 2196
> > 
> > before change: <LBB12_413> follows <LBB12_410>
> > after change: <LBB3_275> follows <LBB3_274>
> > 
> > <LBB12_413> and <LBB3_275> is very much different
> > 
> > and  <LBB3_275> instruction 2198 is the one with "R1 invalid mem access
> > 'inv'"
> > 
> > Why <LBB3_275> follows <LBB3_274> ? from C code, <LBB3_275> is not close
> > to <LBB3_274>.
> 
> The cilium code has a lot of functions inlined and after inlining, clang may
> do reordering based on its internal heuristics. It is totally possible slight
> code change may cause generated codes quite different.
> 
> Regarding to
> > and  <LBB3_275> instruction 2198 is the one with "R1 invalid mem access
> > 'inv'"
> 
> 
> > 00000000000044a8 <LBB3_275>:
> > ;       __u8 new_ttl, ttl = ip4->ttl;
> >      2197:       79 a1 38 ff 00 00 00 00 r1 = *(u64 *)(r10 - 200)
> >      2198:       71 13 16 00 00 00 00 00 r3 = *(u8 *)(r1 + 22)
> > ;       if (ttl <= 1)
> >      2199:       25 03 01 00 01 00 00 00 if r3 > 1 goto +1 <LBB3_277>
> >      2200:       05 00 20 ff 00 00 00 00 goto -224 <LBB3_253>
> 
> Looks like "ip4" is spilled on the stack. and maybe the stack save/restore for
> "ip4" does not preserve its original type.
> This mostly happens to old kernels, I think.
> 

the kernel 4.18 on Centos8, I also custom build most recent mainline git 
kernel 5.13 on Centos8, I recall I got same invaid memory access 

> If you have verifier log, it may help identify issues easily.

Here is the complete verifer log, I skipped the BTF part

level=warning msg="Prog section '2/7' rejected: Permission denied (13)!" 
subsys=datapath-loader
level=warning msg=" - Type:         3" subsys=datapath-loader
level=warning msg=" - Attach Type:  0" subsys=datapath-loader
level=warning msg=" - Instructions: 2488 (0 over limit)" 
subsys=datapath-loader
level=warning msg=" - License:      GPL" subsys=datapath-loader
level=warning subsys=datapath-loader
level=warning msg="Verifier analysis:" subsys=datapath-loader
level=warning subsys=datapath-loader
level=warning msg="Skipped 158566 bytes, use 'verb' option for the full 
verbose log." subsys=datapath-loader
level=warning msg="[...]" subsys=datapath-loader
level=warning msg="-136=????00mm fp-144=00000000 fp-152=0000mmmm 
fp-160=????mmmm fp-168=mmmmmmmm fp-176=mmmmmmmm fp-184=ctx fp-192=mmmmmmmm 
fp-200=inv fp-208=mmmmmmmm fp-216=inv3 fp-224=mmmmmmmm fp-232=mmmmmmmm 
fp-240=inv128" subsys=datapath-loader
level=warning msg="2437: (0f) r1 += r8" subsys=datapath-loader
level=warning msg="2438: (7b) *(u64 *)(r0 +8) = r1" subsys=datapath-loader
level=warning msg=" R0_w=map_value(id=0,off=0,ks=8,vs=16,imm=0) 
R1_w=inv(id=0) R6=ctx(id=0,off=0,imm=0) 
R7=inv(id=0,umax_value=128,var_off=(0x0; 0xff)) 
R8=inv(id=0,umax_value=128,var_off=(0x0; 0xff)) R9=invP0 R10=fp0 
fp-8=mmmmmmmm fp-16=????mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm 
fp-48=mmmmmmmm fp-88=mmmmmmmm fp-96=00000000 fp-104=00000000 
fp-112=??mmmmmm fp-120=mmmmmmmm fp-128=??mmmmmm fp-136=????00mm 
fp-144=00000000 fp-152=0000mmmm fp-160=????mmmm fp-168=mmmmmmmm 
fp-176=mmmmmmmm fp-184=ctx fp-192=mmmmmmmm fp-200=inv fp-208=mmmmmmmm 
fp-216=inv3 fp-224=mmmmmmmm fp-232=mmmmmmmm fp-240=inv128" 
subsys=datapath-loader
level=warning msg="2439: (05) goto pc+41" subsys=datapath-loader
level=warning msg="2481: (18) r2 = 0x5c7" subsys=datapath-loader
level=warning msg="2483: (67) r2 <<= 32" subsys=datapath-loader
level=warning msg="2484: (77) r2 >>= 32" subsys=datapath-loader
level=warning msg="2485: (b7) r1 = 6" subsys=datapath-loader
level=warning msg="2486: (15) if r2 == 0x1 goto pc-341" 
subsys=datapath-loader
level=warning msg="last_idx 2486 first_idx 2481" subsys=datapath-loader
level=warning msg="regs=4 stack=0 before 2485: (b7) r1 = 6" 
subsys=datapath-loader
level=warning msg="regs=4 stack=0 before 2484: (77) r2 >>= 32" 
subsys=datapath-loader
level=warning msg="regs=4 stack=0 before 2483: (67) r2 <<= 32" 
subsys=datapath-loader
level=warning msg="regs=4 stack=0 before 2481: (18) r2 = 0x5c7" 
subsys=datapath-loader
level=warning msg="2487: (05) goto pc-344" subsys=datapath-loader
level=warning msg="2144: (18) r1 = 0x5c7" subsys=datapath-loader
level=warning msg="2146: (61) r2 = *(u32 *)(r6 +68)" 
subsys=datapath-loader
level=warning msg="2147: (b7) r3 = 39" subsys=datapath-loader
level=warning msg="2148: (63) *(u32 *)(r10 -76) = r3" 
subsys=datapath-loader
level=warning msg="2149: (b7) r3 = 1" subsys=datapath-loader
level=warning msg="2150: (6b) *(u16 *)(r10 -90) = r3" 
subsys=datapath-loader
level=warning msg="2151: (63) *(u32 *)(r10 -96) = r8" 
subsys=datapath-loader
level=warning msg="2152: (63) *(u32 *)(r10 -100) = r2" 
subsys=datapath-loader
level=warning msg="2153: (18) r2 = 0x1d3" subsys=datapath-loader
level=warning msg="2155: (6b) *(u16 *)(r10 -102) = r2" 
subsys=datapath-loader
level=warning msg="2156: (b7) r2 = 1028" subsys=datapath-loader
level=warning msg="2157: (6b) *(u16 *)(r10 -104) = r2" 
subsys=datapath-loader
level=warning msg="2158: (b7) r2 = 0" subsys=datapath-loader
level=warning msg="2159: (63) *(u32 *)(r10 -80) = r2" 
subsys=datapath-loader
level=warning msg="last_idx 2159 first_idx 2481" subsys=datapath-loader
level=warning msg="regs=4 stack=0 before 2158: (b7) r2 = 0" 
subsys=datapath-loader
level=warning msg="2160: (63) *(u32 *)(r10 -84) = r2" 
subsys=datapath-loader
level=warning msg="2161: (7b) *(u64 *)(r10 -72) = r2" 
subsys=datapath-loader
level=warning msg="2162: (7b) *(u64 *)(r10 -64) = r2" 
subsys=datapath-loader
level=warning msg="2163: (63) *(u32 *)(r10 -88) = r1" 
subsys=datapath-loader
level=warning msg="2164: (6b) *(u16 *)(r10 -92) = r7" 
subsys=datapath-loader
level=warning msg="2165: (67) r7 <<= 32" subsys=datapath-loader
level=warning msg="2166: (18) r1 = 0xffffffff" subsys=datapath-loader
level=warning msg="2168: (4f) r7 |= r1" subsys=datapath-loader
level=warning msg="2169: (bf) r4 = r10" subsys=datapath-loader
level=warning msg="2170: (07) r4 += -104" subsys=datapath-loader
level=warning msg="2171: (bf) r1 = r6" subsys=datapath-loader
level=warning msg="2172: (18) r2 = 0xffffa0c68cae1600" 
subsys=datapath-loader
level=warning msg="2174: (bf) r3 = r7" subsys=datapath-loader
level=warning msg="2175: (b7) r5 = 48" subsys=datapath-loader
level=warning msg="2176: (85) call bpf_perf_event_output#25" 
subsys=datapath-loader
level=warning msg="last_idx 2176 first_idx 2481" subsys=datapath-loader
level=warning msg="regs=20 stack=0 before 2175: (b7) r5 = 48" 
subsys=datapath-loader
level=warning msg="2177: (b7) r1 = 39" subsys=datapath-loader
level=warning msg="2178: (b7) r2 = 0" subsys=datapath-loader
level=warning msg="2179: (85) call bpf_redirect#23" subsys=datapath-loader
level=warning msg="2180: (bf) r9 = r0" subsys=datapath-loader
level=warning msg="2181: (bf) r1 = r9" subsys=datapath-loader
level=warning msg="2182: (67) r1 <<= 32" subsys=datapath-loader
level=warning msg="2183: (77) r1 >>= 32" subsys=datapath-loader
level=warning msg="2184: (15) if r1 == 0x0 goto pc+57" 
subsys=datapath-loader
level=warning msg=" R0_w=inv(id=0) 
R1_w=inv(id=0,umax_value=2147483647,var_off=(0x0; 0x7fffffff)) 
R6=ctx(id=0,off=0,imm=0) 
R7=inv(id=0,umin_value=4294967295,umax_value=1099511627775,var_off=(0xffffffff; 
0xff00000000),s32_min_value=-1,s32_max_value=0,u32_max_value=0) 
R8=inv(id=0,umax_value=128,var_off=(0x0; 0xff)) R9_w=inv(id=0) R10=fp0 
fp-8=mmmmmmmm fp-16=????mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm 
fp-48=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm 
fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=??mmmmmm fp-120=mmmmmmmm 
fp-128=??mmmmmm fp-136=????00mm fp-144=00000000 fp-152=0000mmmm 
fp-160=????mmmm fp-168=mmmmmmmm fp-176=mmmmmmmm fp-184=ctx fp-192=mmmmmmmm 
fp-200=inv fp-208=mmmmmmmm fp-216=inv3 fp-224=mmmmmmmm fp-232=mmmmmmmm 
fp-240=inv128" subsys=datapath-loader
level=warning msg="2185: (18) r2 = 0xffffff60" subsys=datapath-loader
level=warning msg="2187: (1d) if r1 == r2 goto pc+9" 
subsys=datapath-loader
level=warning subsys=datapath-loader
level=warning msg="from 2187 to 2197: R0=inv(id=0) R1=inv4294967136 
R2=inv4294967136 R6=ctx(id=0,off=0,imm=0) 
R7=inv(id=0,umin_value=4294967295,umax_value=1099511627775,var_off=(0xffffffff; 
0xff00000000),s32_min_value=-1,s32_max_value=0,u32_max_value=0) 
R8=inv(id=0,umax_value=128,var_off=(0x0; 0xff)) R9=inv(id=0) R10=fp0 
fp-8=mmmmmmmm fp-16=????mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm 
fp-48=mmmmmmmm fp-64=mmmmmmmm fp-72=mmmmmmmm fp-80=mmmmmmmm fp-88=mmmmmmmm 
fp-96=mmmmmmmm fp-104=mmmmmmmm fp-112=??mmmmmm fp-120=mmmmmmmm 
fp-128=??mmmmmm fp-136=????00mm fp-144=00000000 fp-152=0000mmmm 
fp-160=????mmmm fp-168=mmmmmmmm fp-176=mmmmmmmm fp-184=ctx fp-192=mmmmmmmm 
fp-200=inv fp-208=mmmmmmmm fp-216=inv3 fp-224=mmmmmmmm fp-232=mmmmmmmm 
fp-240=inv128" subsys=datapath-loader
level=warning msg="2197: (79) r1 = *(u64 *)(r10 -200)" 
subsys=datapath-loader
level=warning msg="2198: (71) r3 = *(u8 *)(r1 +22)" subsys=datapath-loader
level=warning msg="R1 invalid mem access 'inv'" subsys=datapath-loader
level=warning msg="processed 1802 insns (limit 1000000) 
max_states_per_insn 4 total_states 103 peak_states 103 mark_read 49" 
subsys=datapath-loader
level=warning subsys=datapath-loader
level=warning msg="Error filling program arrays!" subsys=datapath-loader
level=warning msg="Unable to load program" subsys=datapath-loader
 



> > 
> > 
> > 2, Can I assume the verifier is to simulate the order of BPF byte
> > code execution in run time, like if without any jump or goto in
> > <LBB3_274>, <LBB3_275> will be executed after <LBB3_274>?
> 
> The verifier will try to verify both paths, jumping to LBB3_289
> or fall back to LBB3_275.
> 
> > 
> > 
> > 
> > Enterprise Network Engineer
> > F5 Networks Inc
> > https://www.youtube.com/c/VincentLi
> > 
> 

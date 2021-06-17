Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5923AA7DD
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 02:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhFQAH7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 20:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhFQAH7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 20:07:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F3FC061574
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 17:05:51 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k5so2752148pjj.1
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 17:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mime-version;
        bh=ZY38JLz5NvfHo/rKD6yp8DD86Bwb0MJBw/QbSYQ2W0g=;
        b=A1MlBu+0ZZ3Ck/UYbg5G0FXSlyuhJ+iMyGwpxXVkpgDHpEupdJK/3eTCOxgvizYYSL
         xI4qeVEReXmOkEGf5Uch6IbThJo1oKYTe5ajtih+zsQ60SJPImuQxjPQuoOb6u3OBYGN
         cmS5gQ5wHCKtQVaxN9azQpxmy1kd9V8phtF9gdW+SlNeLvJMd8KusiKzka+Sk5TWA5Wb
         H6w+qYoTpZcmWlH2hrCW/Hz2vy4uMy4a4U7+c3hVBblkVVK0McNIVNjsWv+6kPU6ooyK
         MEyie4ESdSvX3rNM5EPGLd//5cZAMgSPiNe34fz78R6mxHFGZJQ4slWsboGa1bhyEY2I
         lQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version;
        bh=ZY38JLz5NvfHo/rKD6yp8DD86Bwb0MJBw/QbSYQ2W0g=;
        b=K4XsICxdf/6TBDY9qJeG4ga/AJut58ufhaEXSYNee7utLcID0NgnkIyhvzwnKSeU1d
         +mkVyPO9TJypdbScuVP+SQoKK9HMbeIClXErGv5OKjNeaHN6EJzkqAYDEmYiptIt9l3N
         VmiK+Hb075pARKGsRhfaUj/KfxPT4OUjpPKnHMfjgOmKeqTVgu8E2hhGvzODMQm3IqaC
         DkicIqVSdpc17cKmUjNlNSHlVqqis4OMtEP5ePAdMYZs5RsQg9AuXqPy5uJ8VZDfvH7J
         3khbsIwhbtZhYx3PjCkdet9dtiyf21kzo7Tgv1bBKGMC23+t36TXTNF9D9y/tIoEKbbg
         73ug==
X-Gm-Message-State: AOAM530YMYDDDEvQcHocgWrm28+Ypsj55mkvx3Fz2b1hCxH3uNJedpUa
        j4kU6IY9H1g46BliJN506r0D4PiubNc=
X-Google-Smtp-Source: ABdhPJzBZmmTRQ/kxMahg9bORi+3VzAOpT6+Mrshx34VQEpA48KME0j6Kg+Zs8lNu4cZ1jCOzKIb+A==
X-Received: by 2002:a17:90a:b64:: with SMTP id 91mr2453816pjq.24.1623888350616;
        Wed, 16 Jun 2021 17:05:50 -0700 (PDT)
Received: from sea-l-00029082.olympus.f5net.com (d66-183-43-174.bchsia.telus.net. [66.183.43.174])
        by smtp.gmail.com with ESMTPSA id cv6sm3165721pjb.12.2021.06.16.17.05.49
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 17:05:49 -0700 (PDT)
From:   Vincent Li <vincent.mc.li@gmail.com>
X-Google-Original-From: Vincent Li <vli@gmail.com>
Date:   Wed, 16 Jun 2021 17:05:48 -0700 (PDT)
To:     bpf@vger.kernel.org
Subject: R1 invalid mem access 'inv'
Message-ID: <c43bc0a9-9eca-44df-d0c7-7865f448cc24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi BPF Experts,

I had a problem that verifier report "R1 invalid mem access 'inv'" when 
I attempted to rewrite packet destination ethernet MAC address in Cilium 
tunnel mode, I opened an issue 
with detail here https://github.com/cilium/cilium/issues/16571:

I have couple of questions in general to try to understand the compiler, 
BPF byte code, and the verifier.

1 Why the BPF byte code changes so much with my simple C code change

a: BPF byte code  before C code change:

0000000000006068 <LBB12_410>:
    3085:       bf a2 00 00 00 00 00 00 r2 = r10
;       tunnel = map_lookup_elem(&TUNNEL_MAP, key);
    3086:       07 02 00 00 78 ff ff ff r2 += -136
    3087:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
    3089:       85 00 00 00 01 00 00 00 call 1
;       if (!tunnel)
    3090:       15 00 06 01 00 00 00 00 if r0 == 0 goto +262 <LBB12_441>
;       key.tunnel_id = seclabel;
    3091:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0 ll
    3093:       67 02 00 00 20 00 00 00 r2 <<= 32
    3094:       77 02 00 00 20 00 00 00 r2 >>= 32
    3095:       b7 01 00 00 06 00 00 00 r1 = 6
    3096:       15 02 02 00 01 00 00 00 if r2 == 1 goto +2 <LBB12_413>
    3097:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll

00000000000060d8 <LBB12_413>:
;       return __encap_and_redirect_with_nodeid(ctx, tunnel->ip4, 
seclabel, monitor);


b: BPF byte code  after C code change:

the C code diff change:

diff --git a/bpf/lib/encap.h b/bpf/lib/encap.h
index dfd87bd82..19199429d 100644
--- a/bpf/lib/encap.h
+++ b/bpf/lib/encap.h
@@ -187,6 +187,8 @@ encap_and_redirect_lxc(struct __ctx_buff *ctx, __u32 
tunnel_endpoint,
                       struct endpoint_key *key, __u32 seclabel, __u32 
monitor)
 {
        struct endpoint_key *tunnel;
+#define VTEP_MAC  { .addr = { 0xce, 0x72, 0xa7, 0x03, 0x88, 0x58 } }
+       union macaddr vtep_mac = VTEP_MAC;
 
        if (tunnel_endpoint) {
 #ifdef ENABLE_IPSEC
@@ -221,6 +223,8 @@ encap_and_redirect_lxc(struct __ctx_buff *ctx, __u32 
tunnel_endpoint,
                                                seclabel);
        }
 #endif
+       if (eth_store_daddr(ctx, (__u8 *) &vtep_mac.addr, 0) < 0)
+               return DROP_WRITE_ERROR;
        return __encap_and_redirect_with_nodeid(ctx, tunnel->ip4, 
seclabel, monitor);
 }

the result BPF byte code 

0000000000004468 <LBB3_274>:
    2189:       bf a2 00 00 00 00 00 00 r2 = r10
;       tunnel = map_lookup_elem(&TUNNEL_MAP, key);
    2190:       07 02 00 00 50 ff ff ff r2 += -176
    2191:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
    2193:       85 00 00 00 01 00 00 00 call 1
    2194:       bf 07 00 00 00 00 00 00 r7 = r0
    2195:       79 a6 48 ff 00 00 00 00 r6 = *(u64 *)(r10 - 184)
;       if (!tunnel)
    2196:       55 07 94 00 00 00 00 00 if r7 != 0 goto +148 <LBB3_289>

00000000000044a8 <LBB3_275>:
;       __u8 new_ttl, ttl = ip4->ttl;
    2197:       79 a1 38 ff 00 00 00 00 r1 = *(u64 *)(r10 - 200)
    2198:       71 13 16 00 00 00 00 00 r3 = *(u8 *)(r1 + 22)
;       if (ttl <= 1)
    2199:       25 03 01 00 01 00 00 00 if r3 > 1 goto +1 <LBB3_277>
    2200:       05 00 20 ff 00 00 00 00 goto -224 <LBB3_253>


You can see that:

before change:  <LBB12_410>  
after change    <LBB3_274>

is different that <LBB12_410> has instructions 3091, 3092... but 
<LBB3_274> end with instruction 2196

before change: <LBB12_413> follows <LBB12_410> 
after change: <LBB3_275> follows <LBB3_274>

<LBB12_413> and <LBB3_275> is very much different

and  <LBB3_275> instruction 2198 is the one with "R1 invalid mem access 
'inv'"

Why <LBB3_275> follows <LBB3_274> ? from C code, <LBB3_275> is not close 
to <LBB3_274>.


2, Can I assume the verifier is to simulate the order of BPF byte 
code execution in run time, like if without any jump or goto in 
<LBB3_274>, <LBB3_275> will be executed after <LBB3_274>?



Enterprise Network Engineer
F5 Networks Inc
https://www.youtube.com/c/VincentLi

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33FF234468
	for <lists+bpf@lfdr.de>; Fri, 31 Jul 2020 13:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbgGaLNh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jul 2020 07:13:37 -0400
Received: from mout.web.de ([212.227.15.4]:49803 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732104AbgGaLNg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 07:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1596194006;
        bh=4eNkhJRF4Favo2+6YEjlHafNJSUkK4sRWeWyXWV9X0k=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=oIT7D65JhvBRrjSLR3DZaXuIUOjkbxQJ26kjCy1wMfpM1+ETnaEGaxeCcZwqXQnV5
         9ZI8uC3g1BKRXU6xFPCO+Pa9928F4FBWlJIEhbOjm5fGJzGHohiqMdVRsfohggNt6r
         /ZKsQu1+eyfme9/4AnhgQvd5umhzEqGdTbwySsIc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([95.115.7.237]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lcxjk-1kRgzW30a0-00iDqv; Fri, 31
 Jul 2020 13:13:26 +0200
To:     bpf@vger.kernel.org, daniel@iogearbox.net
From:   Jerry Crunchtime <jerry.c.t@web.de>
Subject: [PATCH bpf v2] libbpf: Fix register in PT_REGS MIPS macros
Message-ID: <43707d31-0210-e8f0-9226-1af140907641@web.de>
Date:   Fri, 31 Jul 2020 13:13:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z79CnrG+1G/KqUIlF3I7lNA+g6Mqz8nB2vtWG/0C6+KO4ollhxb
 nhihf+Q9zQDc4sY2BEjy/57wo/juxdZvnpsqSI/RdvkhQvovsquvdkUrCVWBzN8Xa/UhruV
 GHJCl7r5hkXdbhvMsV5IrvUcgtpJdzz7tvn0SouvdNEv6pXNDQLVcx2HX0NrDjinVKt43m0
 x7V64W+42m53TsAcKWkKg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DsKoI7GjRoY=:A6F6kxOdg5yZCF/pPSdi9R
 PynfmoHsUTZcb/v2Dcuh2Hetk7Gs3xJ0Fs8iTMuSU0Gk+rut+CiVC5nCXiKf9VMSEbjeb6Xzy
 T6s6kpRVIOd03qFTl1If6YO804/SwJ2xGFm3t6A4NRI4Sm+UZg8x8wES6zqJyP4r+kAmWluVH
 7msE40H8Q/VkZjz0XHT0YPivzl08CUZYJ0883rCEhlmcE4jG/mYaZRKEEQA0RGgd7xfZwxpeL
 wQYHENVyFW/Uk7A7Gq54DjsNOzV7nzXKZkmAixiHhfqLTR6/hZ4jSAmg5Z1xHetLSiG4sn9/b
 dIAJwef3KE64t0AFJ7RLyu7MepI5RuzpEl0yFakJ6eSZaTy+K467eaMZE3OG1P9Kx+v/CcyB3
 m1FnDT64qky1LckaytNt9m+NYWMVRhqJI2qibLWG9v/ZTMm0gQ9hVKfn8mhT7tRbX/ySMwZzG
 WOe6/ts81FLCx3SpX3rzM7n0lDT5S0Njxl5QLnh1KKsQGP5/Wa7GqN9zzT3R/dm18Ou3DfL0y
 SQg/S4WjZlpqk6kfeptZvS/OCMy66lCjFDzmEvldzL3Z14JhiRJ+c4+hJ13NTyC4l/HH3GLIE
 k1Q55A293vTyqdClg/aJ0o/Ie75C/iu9vE3+RLq2YQOkzeI/xm9qoR5CrH7a4cyORsZy9jRHt
 yquNwpEAsDUNGy9oJoHEyqm0Hn4Urj8SXyWdpeqh+6VXo8yzgwwPlmu3kpNJjBDugJLvXfHo/
 mw3NvI+EqzBnxC4XSZsoClgtHmlnI5Ed5V9hcQCsj5kfslJ1qNM7Nkm1yOMcBeXwUPp4ykB63
 RdeYWbzSXXSrd+F+lJQNnTKiiDvV3fARiyRZAoWO6EEoxXxhlm+3DDgwZq2skCDHwfuWsvnXi
 /ihldO9lSZxUphOS7wpiOOxLV9gpVJOjYIXgCspdfruF6GNelhLYjON0VJofAMGFKU+kBeN3+
 H05V4uOYFrspcEiqNApqjMEJE0KDNOYEte9ySvdYO2qvkstAMLSGZcfQHGtpJn3j79I4dBgv9
 YpDKputUxLCvjDOfjL1B3P5bcJxpTOKRarE2LVTJinutkXKBhtAnpxJDStOdPKVXae1V6Gs8s
 CUyUhZX5+ibag68m/qTLJW5iej6+ds8WJPWc+LN15WZeQKDRChL5osR8rXCk8E37eP88PCfg3
 7swa1njBBwHzIowRVnfyFbyqN9KG/kav/H3r9vjSaCYmK82qFLCoXn/WfZfXZrimTE+sP2SUz
 twC/Efxq5llcB5vb/
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v1 -> v2: Also fixed missed PT_REGS_RC_CORE macro

Hi.

The o32, n32 and n64 calling conventions require the return
value to be stored in $v0 which maps to $2 register, i.e.,
the register 2.

Fixes: c1932cd ("bpf: Add MIPS support to samples/bpf.")
Signed-off-by: Jerry Crunchtime <jerry.c.t@web.de>
=2D--
  tools/lib/bpf/bpf_tracing.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 58eceb884..eebf020cb 100644
=2D-- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -215,7 +215,7 @@ struct pt_regs;
  #define PT_REGS_PARM5(x) ((x)->regs[8])
  #define PT_REGS_RET(x) ((x)->regs[31])
  #define PT_REGS_FP(x) ((x)->regs[30]) /* Works only with
CONFIG_FRAME_POINTER */
-#define PT_REGS_RC(x) ((x)->regs[1])
+#define PT_REGS_RC(x) ((x)->regs[2])
  #define PT_REGS_SP(x) ((x)->regs[29])
  #define PT_REGS_IP(x) ((x)->cp0_epc)

@@ -226,7 +226,7 @@ struct pt_regs;
  #define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), regs[8])
  #define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), regs[31])
  #define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), regs[30])
-#define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), regs[1])
+#define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), regs[2])
  #define PT_REGS_SP_CORE(x) BPF_CORE_READ((x), regs[29])
  #define PT_REGS_IP_CORE(x) BPF_CORE_READ((x), cp0_epc)

=2D-
2.17.1

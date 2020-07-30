Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB3F23311B
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 13:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgG3Lo3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 07:44:29 -0400
Received: from mout.web.de ([212.227.15.14]:42083 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgG3Lo3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jul 2020 07:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1596109467;
        bh=bU/MFbqJw2aO6JDOdk8DfgdVihRLlc7fwbAEZIOQP5I=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=Up6UeNDRYXHh03BzuDCbyI7hLBRXBp7H/40R+olR/FzTdG07rd1BCLVKg5DFjekUp
         SmjybqNur0cCDKQZOyhgHKDMA7O0fQR87kSdBRYZzqfSrg1ZRk87Ni8zqS+LIjLFi5
         VQIjQlPIe5IY53oXKknN2C1RTKwrZaEpNlcco03c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([77.2.34.38]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElZP-1jyaoa2Xmd-00GIQJ for
 <bpf@vger.kernel.org>; Thu, 30 Jul 2020 13:44:27 +0200
From:   Jerry Cruntime <jerry.c.t@web.de>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf] libbpf: Fix register in PT_REGS MIPS macros
Message-ID: <05fb9d72-d1a7-5346-b55b-4495cdf54124@web.de>
Date:   Thu, 30 Jul 2020 13:44:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+jK3b068ShNLhN+CJ3Zj1XyFDGs6beUJTvc3ww5pKs7qvoM3iVW
 O/LU8uXRyZWZl6jqQHeCwBGKG5wF4+CxlhLYylBuBFUKUt3MCY5FQAR7XK9XWoFnIgwIvdm
 wLSzto558aOImLHe1MYmXNHeiogZbGnp0XBstAtviklUWiJ/zVqW4o9/44BXKKPd17PtTmE
 pDThA+F/IekMBMP1xvI6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ktLmlzUaoFc=:0Jhua8lkFdDkO7ukjXzMrd
 Ik2jmvZwUBnif6B7fRHqY1S786cTGwTnzVAJ9AhbaMPUD2NS+oV6R4/5aoZTdsS7DJvDi48DB
 5Qid+Bjjkm20Gseg8I7RdwvxTX8WmlljRleTIkvADo3f8MoFnvwhLuXPBsPxRiqcESuXVlYNU
 9rRsH3JxWbjHOTAgg1yb/cTX9YcAIu8Bz7LP4yb146vJOyncRCYP3l1+7q0Orb6vi6ITG9ugE
 HzpoZvunOIVVdQl6gRLdhiUICWLMjsGH4R2xlrveLnSmxsdsJgLeC+r8xsBsQThQZxEnZzbWi
 rZZTuwkUbCTK7MojzCa9N4zXmQVcdE2VUaKpZ4jDDzXLyNFynXcqr26wDgPa8iDJcqyaXLtcj
 sxnEOYIu6MSAe3Lm6bX664xGJpNGrMJ9uGkElqYm+CU6XOMoRBIHwwp/G3vWKrLPk1NSZaTM6
 7z9KRvyaQOi+CDH+plBWIcTmcA0Ja+qvfJdKhqUOb2wr3sX88m65KglPKHByTre8IIdSbGTwy
 eDQEBEvcAKcuHVzs0fBC6LQLM2JUD9WBPPs2eIXAedGTzNloJMwOrwBlhROORBTf/F7LlBNT/
 TixMCXl/yJOuxnVseQyz1uGSM1knmYffh8p6dU94JSUssTaxSd4X4atN13fRB7zfdJlyZ7YHP
 4mMrambQerf1oIgvEZwP4F4OYVfBvH0qAXRfUszIZADvjUV4oeqiFOGw0ca6KalaF5viEqPOo
 cCjsw2A89nq/Zv5R9cMwxIFhfkgkFYRAd4H3YuiJi/NAqPWZFSxhPI88P3jPhOndJoWxCWrAR
 Cksn6wBnYSYFKdeQoRSCMhsH2n89LYqWiRKooatuGEVMWjsbqnzPLZlMGMMxW3tB26dPG5YhX
 kLXnZow5kojD1QgoEoRBZF2STKkF8wujIP1WNM+C3qwhmPjSFAxg1MnVSMP12WmF4XCBi6ilg
 1I5wmEHeT6VAolua1svYngNebVC2KM2Q8XVRreCv1HKe3xgUOFDunb9b8dlR4XAT5C/MnjSaa
 +nDe1aCVKrWUXCK//OQJmgIWH9tII9tAE7Bg5/l7Zqu1KY5sAqnJ1qhjkSQsONhIgx+HM5gfm
 87DAV00PR/OiGkDv6vIjy22Fmb5cl50jkR6NYtNOKXAxAFwDjGvKG8jTI6fCb+QVSE3rm7W+U
 zedvvHtyc1Nk8LNmBl4EaexNWkcCILjA0S0RYhs3Lfke6EDDfofoZrLTyB/lNgL0HURBtEK7W
 RKRMufumARc3B6D3d
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The o32, n32 and n64 calling conventions require the return
value to be stored in $v0 which maps to $2 register, i.e.,
the second register.

Fixes: c1932cd ("bpf: Add MIPS support to samples/bpf.")
=2D--
  tools/lib/bpf/bpf_tracing.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 58eceb884..ae205dcf8 100644
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

=2D-
2.17.1

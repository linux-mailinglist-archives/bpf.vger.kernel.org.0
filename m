Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7FC168751
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 20:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgBUTT0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Feb 2020 14:19:26 -0500
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:35567
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729509AbgBUTT0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Feb 2020 14:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582312764; bh=BUNa1nluT8rqDijZ3UcWO1egSBKenvU91nwbzbuA2wM=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=GUfQ+Xkf2FsnWrld55ddOSJMEXsDDpURtrRkLx/X9/cJv5HtkGHEt+eucfLniuSaJQ6qD3gP81sabjyBDPP8KlU3izOL12VwPkdtpOrKtQ6Rukyyb3N1X876p6OBGTQ5gobOjdg4IZ69cy1o70D2FNJ92OAtttwzcZAxzahJsMSStv757b/n4s854DGVa15Tx87BUie0XCeTRoidLo8uGgs5w6dsQIhq7vBWn71zbb8caynkgn1s/DQamXDZ+Emc9B9qZSJw0MJ5zpnIY2BFf2p6Lrt0uvtN1WSS6o3H88MokuiYr/kjTSUiD6bfw8GPdTOqUiq06uSRIL7iNj4LvA==
X-YMail-OSG: kJ7cJVAVM1nus4aH1fzxvHZ2G3VxDnt3hHcqNo6syOo_lkVSwBGzi2TqXY3.zSP
 heNcLLa0kn7bq.fLvrb_vC2kCLNK_S8tpw1FLzxlMFvlIxLLLMTYDsgXns_LELg4vb2Lc_htyyU1
 94_DmV2.IBgbGceRcmxifojI0yxFMwvnuecGFHFvyYs0Wn0lgsckb6xq6JM_EFUH5fDHL6PnDudr
 NJ._IqiX_rHVbjhPOwTmc0aCk3I2YBoGeGBcWrp2FR3XU7EJBAWPmydBiV4LucDiEOoJ98KEDfJC
 cS5DPEKy1vd20sa4UL5wiSKeb4trofaM86TJrstIGLTdpZ6D5aFBcmjsSARJ1OcXypShn6_57F0q
 eai9230VAInCLSnsnzt9s1h8VnYjWB42ESMwTA7tmAsxcc9Lp8zo9LSpN8zcZ3EoxYry0q3pEtAj
 JQgn9Vs9dyS92aq7h7PA8cyMJl_GAwbBP7mIHqsln7wRj7CStcE9Ep0ZqNsp5sXUPbHKqenWcig5
 gPPbM6ckT3uJJLoGzgpjoCrkfCfvzp4SLRHowhQJ6zXcCp4NFyJXHX0z8mA_.jZHdPMpyDAuhYpZ
 6vGs1veP3vQGS6yiU40M7Mjj1GWa9KBRbR8aHJHb8U9kKkOY6xy6rk1dVJFXlg3jVziGCod6WGZX
 aWLxz1EQbOps5UJkKMDUbXVyzSnIqxbmsJiqRsYNV.z847RfiWEKsd3iAUKyQHFnQMtUvDSDZiJl
 UfMZUaM05qslIgHGx5mneUuivuL.kWFPt.4hVfPLAKGVYayD6_4ydTuX0bqtvPaazivo52Edyb2z
 VWCnqRMF86WeQuGy62y27Zwa.jOMY62RBNxCs_1eM_FocXXsAP_7D_5jewAODRJTxn3P8NQuI9Ag
 WNTXVv6MeaOWE_AFOuIo5yTiPNjjbpeEiXl4Rmhwkozfe6lmDMXMFEj9ssBbEMa4WVYZpNBiM.XX
 b4YPzRK51VOFnNjZpp.1TMnxEHwbwSgJcOlWy6TszQZl5opl1awCsapH2jmGVDl.Raoy5dYN5M7T
 LCfQNnwriex3Zz2JM9nQMCQPwMtutM5I82n3Ulj1wIuX4f0uvhYBO.3HsgO6pdy47NHo0walcxzV
 QiXZKxkBAe8Dk1snYS7x.OKPYkwvwu3QHCaF0AlCGhdUxIuvlMpVV_wV3T1ePtpjCLEXCtMpnfLC
 MBMWs2WVYRt5TB75HKlF7SJy2x1zNqYkCUWF1yx1_Y98XiTR0cCeD9m5p1STmHWd6uTQHBXnBENM
 v9K60HhpOLBmqMYSG2wfIX4s5CaUKHLiGrhz6v.Qd6sQ3TManWJ2CwXRKCvFzds21mTOhJbH0WXK
 idwdN_0shjbUGbuusj1Fb2AKFeu.gpVW_R0qHttumMSHDihWZidyJY5q5o9wiMAjN3BtmE_YU17B
 IfFelfpFK0y7S.BiXRSTA.MwbT6KAtWfO0BYQjWBT
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Feb 2020 19:19:24 +0000
Received: by smtp420.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dca2c11717bd12e4e3809abeb9d8b9dd;
          Fri, 21 Feb 2020 19:19:22 +0000 (UTC)
Subject: Re: [PATCH bpf-next v4 0/8] MAC and Audit policy using eBPF (KRSI)
To:     KP Singh <kpsingh@chromium.org>
References: <20200220175250.10795-1-kpsingh@chromium.org>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <85e89b0c-5f2c-a4b1-17d3-47cc3bdab38b@schaufler-ca.com>
Date:   Fri, 21 Feb 2020 11:19:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220175250.10795-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/20/2020 9:52 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>

Again, apologies for the CC list trimming.

>
> # v3 -> v4
>
>   https://lkml.org/lkml/2020/1/23/515
>
> * Moved away from allocating a separate security_hook_heads and adding =
a
>   new special case for arch_prepare_bpf_trampoline to using BPF fexit
>   trampolines called from the right place in the LSM hook and toggled b=
y
>   static keys based on the discussion in:
>
>     https://lore.kernel.org/bpf/CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=
=3Do_6B6+Q-u5g@mail.gmail.com/
>
> * Since the code does not deal with security_hook_heads anymore, it goe=
s
>   from "being a BPF LSM" to "BPF program attachment to LSM hooks".

I've finally been able to review the entire patch set.
I can't imagine how it can make sense to add this much
complexity to the LSM infrastructure in support of this
feature. There is macro magic going on that is going to
break, and soon. You are introducing dependencies on BPF
into the infrastructure, and that's unnecessary and most
likely harmful.

Would you please drop the excessive optimization? I understand
that there's been a lot of discussion and debate about it,
but this implementation is out of control, disruptive, and
dangerous to the code around it.



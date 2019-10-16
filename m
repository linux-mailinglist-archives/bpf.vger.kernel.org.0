Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D58BFD95A9
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2019 17:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390841AbfJPPdS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Oct 2019 11:33:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37616 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfJPPdS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Oct 2019 11:33:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id p14so28579029wro.4
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2019 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=6bo+Ckv0dvhPOejyCby/622sskdAl0b3Wi8KW98Md0c=;
        b=oNl+0fKR4nB+v+plQI21tqIgzIzXtsKe2zigQGgDgmUKQARVHq9oMlqVEzdBzBcM5F
         DemvGgfKNkkOT8VFqUxyw5SGFrKT5LeKdx54BhCXZJLwyE2njAUP+rf7EEkZhyM9pCiM
         FqToAGEj+0/olMKUob0ORKch0ho/FNoyeXHDFynTRyjlTShKFQwwMbcxB4d53jLRRaCT
         BXlnFsAT5CJ/prdB0GVRzTUQjlkRK5YuWQtpdeufAO7SXMIjfTK4coXu7/grFwh3sRjr
         p70Rw2sYX/Q5YAvkdQkzUW1SJd2S+Qsp8IU9zokGrr1eXn0U3VdCUINlh0j3iJWuWQeV
         6Hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=6bo+Ckv0dvhPOejyCby/622sskdAl0b3Wi8KW98Md0c=;
        b=ICtVrUOu9gM7n2LpycxIWoZiKPrM55mflzQSZ9TTYOeappHr1xdGc2wm8xXYew5bEU
         4rzYyDOH4pS8YZSpQ2/OUzsnA6KwVULYhOSx6rsW/Dl607E+d+VTC/Hu+AGTeTbuziWi
         3NSfNSMFqaC/OUift5VD7oGjUj2J5v+B1bzG9NxGXgE0yuRfGT/SmUOm4fBSodi7wdrV
         9BbKisvFfE3AkZ3jL+BJwuSssKKhu46c9dR4ZgEWckiMz6OivYIP2X7ADqsyOlHxkBhq
         DIo16WPqDrEtOhHIHDHsVZoBRe5DKlLhVAJAWiZ3YeZpbc4CpI7RUNSBB7WoKp/s1TZI
         RKGg==
X-Gm-Message-State: APjAAAXaEWl8zVxhSOUK70fZsYLqc4ZvKIIP8lLzo8nSoL5sM31PstTo
        GddOBQXRTYLrhFlc9RdHTwG13Q==
X-Google-Smtp-Source: APXvYqwFbEtL60PJnG3/6vq5QdKSDK7Puu6LkU/X1s76sFOr5Vuz277vqDZzIlILurO58Vd5PAjpkQ==
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr3329021wrp.296.1571239996336;
        Wed, 16 Oct 2019 08:33:16 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id d4sm25054977wrq.22.2019.10.16.08.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 08:33:15 -0700 (PDT)
References: <1570864740-16857-1-git-send-email-jiong.wang@netronome.com> <4bcc6709-cbdf-fbdc-7e5f-103a1160d05a@fb.com> <1rvepbpe.fsf@cbtest28.netronome.com>
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Yonghong Song <yhs@fb.com>,
        "alexei.starovoitov\@gmail.com" <alexei.starovoitov@gmail.com>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "oss-drivers\@netronome.com" <oss-drivers@netronome.com>
Subject: Re: [LLVM PATCH] bpf: fix wrong truncation elimination when there is back-edge/loop
In-reply-to: <1rvepbpe.fsf@cbtest28.netronome.com>
Date:   Wed, 16 Oct 2019 16:33:15 +0100
Message-ID: <4l08k8n8.fsf@cbtest28.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Jiong Wang writes:

> Yonghong Song writes:
>
>> On 10/12/19 12:18 AM, Jiong Wang wrote:
>>> Currently, BPF backend is doing truncation elimination. If one truncation
>>> is performed on a value defined by narrow loads, then it could be redundant
>>> given BPF loads zero extend the destination register implicitly.
>>> 
>>> When the definition of the truncated value is a merging value (PHI node)
>>> that could come from different code paths, then checks need to be done on
>>> all possible code paths.
>>> 
>>> Above described optimization was introduced as r306685, however it doesn't
>>> work when there is back-edge, for example when loop is used inside BPF
>>> code.
>>> 
>>> For example for the following code, a zero-extended value should be stored
>>> into b[i], but the "and reg, 0xffff" is wrongly eliminated which then
>>> generates corrupted data.
>>> 
>>> void cal1(unsigned short *a, unsigned long *b, unsigned int k)
>>> {
>>>    unsigned short e;
>>> 
>>>    e = *a;
>>>    for (unsigned int i = 0; i < k; i++) {
>>>      b[i] = e;
>>>      e = ~e;
>>>    }
>>> }
>>> 
>>> The reason is r306685 was trying to do the PHI node checks inside isel
>>> DAG2DAG phase, and the checks are done on MachineInstr. This is actually
>>> wrong, because MachineInstr is being built during isel phase and the
>>> associated information is not completed yet. A quick search shows none
>>> target other than BPF is access MachineInstr info during isel phase.
>>> 
>>> For an PHI node, when you reached it during isel phase, it may have all
>>> predecessors linked, but not successors. It seems successors are linked to
>>> PHI node only when doing SelectionDAGISel::FinishBasicBlock and this
>>> happens later than PreprocessISelDAG hook.
>>> 
>>> Previously, BPF program doesn't allow loop, there is probably the reason
>>> why this bug was not exposed.
>>> 
>>> This patch therefore fixes the bug by the following approach:
>>>   - The existing truncation elimination code and the associated
>>>     "load_to_vreg_" records are removed.
>>>   - Instead, implement truncation elimination using MachineSSA pass, this
>>>     is where all information are built, and keep the pass together with other
>>>     similar peephole optimizations inside BPFMIPeephole.cpp. Redundant move
>>>     elimination logic is updated accordingly.
>>>   - Unit testcase included + no compilation errors for kernel BPF selftest.
>>
>> Thanks for the fix. The code looks good. Just two minor comments.
>
> Thanks Yonghong. Your comments make sense to me, will fix them.
>
>> After the fix, could you directly push to the llvm repo?
>
> Sure will do.
>
> (And I will update my llvm account email first, should be quick, if it takes
> too long will come back to you for committing help)

Fix pushed after two minor comments addressed and re-unit-tested:

  https://github.com/llvm/llvm-project/commit/ec51851026a55e1cfc7f006f0e75f0a19acb32d3

Regards,
Jiong

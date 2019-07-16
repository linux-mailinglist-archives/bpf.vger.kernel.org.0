Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6472D6B1A3
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2019 00:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfGPWM3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Jul 2019 18:12:29 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:44163 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGPWM3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Jul 2019 18:12:29 -0400
Received: by mail-qt1-f177.google.com with SMTP id 44so21230129qtg.11
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2019 15:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=qDHnXbU7Ysa2bN6UPo2OM5lnpAcBt26xw5f80BHot6g=;
        b=tmpF3sS1FjltK8nasdTkiYHPf/xk0xcfRlZhf76Es14vFkXe+eIpF2uHSTH8+crSoT
         F39lxkjb4QIu6YcUxCh0F/7qJhzF6wtfHKfbwEPpave7CQoNsVlkTDZoqLoGEbClSJKE
         7FqN/icVRR1o8OPfM/RQcvu7p5uZrqsyM8fk4fFqyfQbox7QA7tJgUV64n6Tw9HNP0Mp
         s+J0yLx6mPGHUwn6hq/0rdTrRncAR+TlqAC4Lw7IhgFojbNFXJWGWeZo8Ywe5Mz/DWaX
         alLqHEhWmEhuin6ZRchS6v+TtgY/Fqs66dpTdiPBueSlrf+iaAldXEvvf3S8Nd/gMFqc
         EGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=qDHnXbU7Ysa2bN6UPo2OM5lnpAcBt26xw5f80BHot6g=;
        b=tNNHGimGDVu3GusHSuAAroguNz3I2HVup/leuac3iCAZTtu2BIM87nUZ5dyG9L938x
         3QLAVvBYyd5tGPSk4UmIRqVEoALZZhvqgv3p37cGLcwPluPGPgNrnDC58t33TMuWWjS9
         kPAeSnsAieLATa+rNyN2kBZdgWDIfHlQVOtQFV4noYIL8/eccUgkHZgGopUcu0fCf5i3
         iIyU+Ftci25sQR7/+uh+AM6J56IY+sqPYuu8qXiDl9fDHoPxpB9MbKfBWo6zRoA+UCuv
         D22atnk7E085QWcwZcykEAsWCzdqPyxGgcnjuFIfYWm0lNJLsUG6Tsk0NZs8Yz1Jhvu0
         UwsQ==
X-Gm-Message-State: APjAAAVEv3jeQl1G8yVIWQ/cwFDfz5nISKG12/EswMx15mu72JraAoWo
        q9cTuy8uR19WGJhQ+ZRpalpamw==
X-Google-Smtp-Source: APXvYqyEcJ8B+1+Psk1jW1CyIaIDhqj84VlcXQpbozPYQzAnwLNGY+Bqc9BhS1ta/WJugYLis6q7sA==
X-Received: by 2002:ac8:244f:: with SMTP id d15mr23913579qtd.32.1563315148694;
        Tue, 16 Jul 2019 15:12:28 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id w24sm11757370qtb.35.2019.07.16.15.12.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 15:12:28 -0700 (PDT)
Date:   Tue, 16 Jul 2019 15:12:23 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Edward Cree <ecree@solarflare.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, oss-drivers@netronome.com,
        Yonghong Song <yhs@fb.com>
Subject: Re: [RFC bpf-next 0/8] bpf: accelerate insn patching speed
Message-ID: <20190716151223.7208c033@cakuba.netronome.com>
In-Reply-To: <20190716161701.mk5ye47aj2slkdjp@ast-mbp.dhcp.thefacebook.com>
References: <1562275611-31790-1-git-send-email-jiong.wang@netronome.com>
        <CAEf4BzavePpW-C+zORN1kwSUJAWuJ3LxZ6QGxqaE9msxCq8ZLA@mail.gmail.com>
        <87r26w24v4.fsf@netronome.com>
        <CAEf4BzaPFbYKUQzu7VoRd7idrqPDMEFF=UEmT2pGf+Lxz06+sA@mail.gmail.com>
        <87k1cj3b69.fsf@netronome.com>
        <CAEf4BzYDAVUgajz4=dRTu5xQDddp5pi2s=T1BdFmRLZjOwGypQ@mail.gmail.com>
        <87wogitlbi.fsf@netronome.com>
        <20190716161701.mk5ye47aj2slkdjp@ast-mbp.dhcp.thefacebook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 16 Jul 2019 09:17:03 -0700, Alexei Starovoitov wrote:
> I don't think we have a test for such 'dead prog only due to verifier walk'
> situation. I wonder what happens :)

FWIW we do have verifier and BTF self tests for dead code removal
of entire subprogs! :)

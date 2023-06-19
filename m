Return-Path: <bpf+bounces-2827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAA9734C20
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 09:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20162280FC1
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 07:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFD23C35;
	Mon, 19 Jun 2023 07:09:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21236210F
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 07:09:37 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD07DD
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 00:09:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f63ab1ac4aso3755727e87.0
        for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 00:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687158574; x=1689750574;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7kPKQBWkCqfXL/YCyDu7OJatGpc+xQgvIt+1p6NnFSk=;
        b=mJ5QZ3rS4xOIr3+xsEmuKE3E0MU3ecWR4V9UILBI2325IZ/tvxL65gjaKu31j0z5/w
         6eNzEFJAxFmRhzkH+GQkTdQTAvLS18hhyU4zST2ix/wiw2KvUKPgs6iihry6Z2W0rrU1
         O57ay5zM9BhEdsbc0VkCjCz1b3w13t9K7BfVCQ2AOgjMOyLos2IwILISaAFepSFnW5eB
         hWpNp6n/RaruNnaNHATAgArK+UAzoUhTiApPuVXGHUn/uokF8QVrYsxVU87canf/Z0zb
         fMfsj+vzOcmFWXgRUK2jBPumpnHFA80xM+wtPkZdmZhtJ2QvwAhz4G8K2DidAax1vgxR
         BHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687158574; x=1689750574;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kPKQBWkCqfXL/YCyDu7OJatGpc+xQgvIt+1p6NnFSk=;
        b=Yt3V7KGQ8cAefljQ5zK/mOybAo4nOEEQO492rGyq/x3A9028WMNQJSkwafsjBfAMFk
         evMEtfRpYNNU9ZeqNbNx+A7N9sORkosAadtlHm+3JNqYzZ1c9RmYzbzBs8wcJauhrWAe
         1rtHjDxHKxLN8/o/u+UM0/e2xuTUWf2BTbG8JGcXp7t+U4USRPfMrpq2kCk6oFKuSSE0
         MdDXAWnVigJPyd0hX8v5tPIsyXp7Hqyyc0Hdf5WHmsq1hNJmbvcaYXl9C+xkGbBvWJmM
         XIkmi/Pz7r2Wk4/8QqF295C4GKsFvVl2EIOVbKs/S8CL5njk5hjHAn6F/uGqijA2J5sf
         qfjQ==
X-Gm-Message-State: AC+VfDxpOwDgtfESC5qPwVdejfwAX/Qp+6T1uwskrAG/2AZgpe8IsR7T
	RVc+JVONXbEiztoVbw8hsh0dBHythLd6S9o6aspIv1sdYM2TP8v4
X-Google-Smtp-Source: ACHHUZ4kbqdIav0sKh0oO3RBA94X4jFU+D7iLgUmAolf7BabNdUsefiCvTvcBLMAXdHOX//puCaH7RxlT0UZvTOvgqM=
X-Received: by 2002:a19:7719:0:b0:4f3:ac64:84f5 with SMTP id
 s25-20020a197719000000b004f3ac6484f5mr3889250lfc.36.1687158574073; Mon, 19
 Jun 2023 00:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Patrick ZHANG <patrickzhang2333@gmail.com>
Date: Mon, 19 Jun 2023 15:09:22 +0800
Message-ID: <CAOqUrdh5xGKM+8aKAmmH7vco5GxAQFej9-tVPD6UkEUg5Nn=vA@mail.gmail.com>
Subject: eBPF Verifier's Design Principles
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi there,
I am not sure I am doing this in the right way.
I am writing to seek your guidance and expertise regarding kernel security.
Specifically, my focus has been on the eBPF environment and its verifier,
which plays a crucial role in ensuring kernel safety.

While conducting my research, I discovered that there are no official
documents available that outline the principles of the verifier.
Consequently, I have endeavored to deduce the kernel safety principles
ensured by the verifier by studying its code. Based on my analysis, I
have identified the following principles:
1. Control Flow Integrity: It came to my attention that the verifier
rejects BPF programs containing indirect call instructions (callx). By
disallowing indirect control flow, the verifier ensures the identification
of all branch targets, thereby upholding control flow integrity (CFI).

2. Memory Safety: BPF programs are restricted to accessing predefined
data, including the stack, maps, and the context. The verifier effectively
prevents out-of-bounds access and modifies memory access to thwart
Spectre attacks, thus promoting memory safety.

3. Prevention of Information Leak: Through a comprehensive analysis of
all register types, the verifier prohibits the writing of pointer-type
registers
into maps. This preventive measure restricts user processes from reading
kernel pointers, thereby mitigating the risk of information leaks.

4. Prevention of Denial-of-Service (DoS): The verifier guarantees the
absence of deadlocks and crashes (e.g., division by zero), while also
imposing a limit on the execution time of BPF programs (up to 1M
instructions). These measures effectively prevent DoS attacks.

I would greatly appreciate it if someone could review the aforementioned
principles to ensure their accuracy and comprehensiveness. If there are
any additional principles that I may have overlooked, I would be grateful
for your insights on this matter.

Furthermore, I would like to explore why the static verifier was chosen as
the means to guarantee kernel security when there are other sandboxing
techniques that can achieve kernel safety by careful design.

The possible reasons I can think of are that verified (and jitted) BPF
programs can run at nearly native speed, and that eBPF inherits the verifier
from cBPF for compatibility reasons.

Thank you very much for your time and attention. I appreciate the  feedback
and insights.

Best,
Patrick


Return-Path: <bpf+bounces-17049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB14809500
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 22:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6081C20C5A
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 21:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F309840EA;
	Thu,  7 Dec 2023 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iINqlfTk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3631A198C
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 13:58:32 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1caddd6d28so193825466b.1
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 13:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701986310; x=1702591110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A7A+asTY8B4TwHgYJ0A4zcHFWRGEh9vFEKmpb47AAdY=;
        b=iINqlfTkgNUvHawO19GUx9UnqUQXr5QOXfxgI7zRNf0P/pcHtXNsF1+TOllc1BBAvc
         4+BVPM2RPQY2A00FuaKitxnonjN/zB92KRQghYMa4QbUxtgckodPXbt5bKr1UsyxBDtJ
         /Tk0j+a8lmUHVhgGuDvkncvkPcb0638ZAF7SdsWf+T88aBqyj7RsmtA5rJC031C+OusF
         Y1myWq7psyh3144MYyQkSTKuDb7ZNN48wrOZtzarnRzmJ5A7bFmf/YbpIF0zXRU3f46a
         ZdZKMf8y82pQndIK0aPpruBJCJlqW29p6DnbsSfC9Bcui00pYmPM6O8dQ8MCnpoktzNR
         KzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701986310; x=1702591110;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7A+asTY8B4TwHgYJ0A4zcHFWRGEh9vFEKmpb47AAdY=;
        b=Akb44O1avgMPAlI8u3jw0YgfjsEn8g6nYx570RGOfN2/iTxRYOJ5nuGuokRbyUc0u6
         8uJhXbmnBcjr9x4F8vkreAihyKsrSTa/wX5I4V3QQYLh6eenyfPOr1V5lrPkUFOnd7VE
         b4yp/i/1LhFp7Iw0u5g7JWa0NQ2jJ0PSDrPnZ1Zi/gRABprATmwoXX/hj8X3nrzsZMIL
         rc6Hj2159R39okXjoqacPPR9mNUuU0iPAm83eK2t/lFRfA9Z5P98LkHdAN9KIxrucWod
         d6GX1MJWsTH9zgEwzcXOPjD7rmMxs0m978a/sSwGAjYD5e0pRvV6f9IR81Wn1chL8veA
         EKEw==
X-Gm-Message-State: AOJu0YyBFU+r1StjXn3fjpIdL9R3caO9ducbYZB8zYwGnYHAy5LqJ3zJ
	W4KxZ05RYcmuLGwJ1oRVtEnZq8uOJeAshE5ikM1wvvkQP/JE8A==
X-Google-Smtp-Source: AGHT+IGZXf6WOkEX6X8AP5w3ygUr5M/mI2eYwnyTa14T3waY8m1U2KAnqmjErxcGbhagQ1pAX3xl6geSU7k9zmXdxU0=
X-Received: by 2002:a17:906:2458:b0:a19:a19b:423b with SMTP id
 a24-20020a170906245800b00a19a19b423bmr1455026ejb.166.1701986310346; Thu, 07
 Dec 2023 13:58:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrei Matei <andreimatei1@gmail.com>
Date: Thu, 7 Dec 2023 16:58:18 -0500
Message-ID: <CABWLsesOeyfiUuV_Mgz3xJ0WfNVeNunRQZsN5Esv-aqNO3iT-Q@mail.gmail.com>
Subject: [bug report] until recently, code for bpf_loop callbacks using stack
 for ctx was mangled by verifier
To: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
Cc: Andrew Werner <andrew@dataexmachina.dev>, kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"

Hello bpf,

We have run into a verifier issue that had us scratching our heads for a while.
The issues has been fixed by Eduard's recent series reworking the verification
of bpf_loop callbacks ("verify callbacks as if they are called unknown number
of times") [1]. I'm not sure if this kind of consequences of the bug that
prompted those patches was understood; we reported the bug originally in [2]
and we certainly did not understand it. The point of this message is to
consider the backporting of that series (or perhaps of a more targeted fix); if
those patches are already slated to be backported, or if what I'm describing is
old news for everyone, maybe you can stop reading and sorry for the noise.

The symptom that we've encountered is an instruction from the input assembly
being erroneously dropped by the verifier. The verifier thinks that one branch
of a conditional jump is never taken (and thus the test and one branch are
eliminated), when in reality it most certainly is. This is similar to
miscompilation and so quite bad for unsuspecting code. In contrast, the bug
report in [2] only imagined that programs can pass verification when they
shouldn't, not that they'll be "miscompiled".

The issue is as follows: before Eduard's patches, the callback passed to
bpf_loop() is verified as if it is only executed once. As such, the state that
the verifier knows about the data referenced by the callback_ctx pointer only
takes into account the possible values of the respective data before the loop
starts; the verifier *does not* take into account the fact that the loop might
execute multiple times and mutate that data referenced by the ctx pointer. The
way this leads to garbage code is:
- inside ctx, you can have a pointer to the stack
- before the first iteration, the respective stack slot is known by the
  verifier to be 0
- the loop callback also has a conditional branch on the respective stack slot
  being != 0
- the loop callback sometimes mutates the respective stack slot
- the verifier assumes that the branch is never taken (so it never verifies
  it), and so the test and the branch are elided by opt_remove_dead_code()
  because the `seen` flag on the branch's instructions is not set

The mitigation on kernels before the fix, I guess, would be to not reference
stack memory from the `ctx`. Instead, limit yourself to map data whose values
are always unknown to the verifier.

If Eduard's patch cannot be backported, I had a random thought that perhaps
dead-code elimination could be partially disabled (perhaps only for loop
callbacks, ignoring the functions that the callbacks call).

Thanks,

- Andrei


[1] https://lore.kernel.org/bpf/20231121020701.26440-1-eddyz87@gmail.com/
[2] https://lore.kernel.org/bpf/CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com/


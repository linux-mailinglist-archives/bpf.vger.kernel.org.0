Return-Path: <bpf+bounces-56975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8787DAA1B5D
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 21:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEA41B679BC
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 19:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEC625E817;
	Tue, 29 Apr 2025 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv/ujwX4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C364324C083;
	Tue, 29 Apr 2025 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745955002; cv=none; b=D781QJV1L/YApSjyfLaEi89udvFHcoQRA/wMeA9R3JvQEb4GvPFjtnRgIbTAhm/duVHEOif6Y/8R+2LSz6kiVdRmxccC4QlV0Hy7NDaMwKPYsYKEN/k2sSje679F6O+4R/BxigoWHJ7h2amsH7uQEV+UhN8J36S6Ie2pXlm15i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745955002; c=relaxed/simple;
	bh=+ZOl3M2dIHJWULlWSHE6FFCfhQG4wjDLumB3GsI2nTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gEkuLaoUdA+cVzMzJnGJ/nVD31Qd6TrxgF8e/rrFIFIHcQnRGGKvMshC1QBo6QKJ2jSAby4pPtVT3vC+jUTPodX1zOJMCNCI8hoqK7aPXhVoq1TKInvBE1f7zkDz03Xd7Ozk6+zJxftwvX7fWzMzpeppcFVkbWS1pl1yZPcRygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kv/ujwX4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224100e9a5cso78712375ad.2;
        Tue, 29 Apr 2025 12:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745955000; x=1746559800; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/retCIRztlEpXR/AW2peSfIyedgB7T3xXb6E6WZilpw=;
        b=Kv/ujwX4Vhvw9AUZDJdwPa2QX/FpoyPHn1eImSbdAK8Hs8W4AbW2pek+Wrp1xgorD0
         PIzbtoRWlIu4gAIFRv4sKRwSTQ1bKG5+yykj8sWcWRF+VV5UJiM7Wg9DSvbpbngPNU6R
         edyqE7TCMNme07tIOlHOO2UmBEdAMv1qPoAGCFThip7VVufFCIEClBKugdvauGBxT4bZ
         1itiWyFREmSdV3isbjy3TauvNfNfbZo4m/8wznUpSSoOUnLyL+MoUp3eLo9A8CxgEAgd
         4tB1M5K5/ZkFOSK5TPumwL/rowguSVNX/2BLXS9Q3geWKAkH5cCFU1GDN604Xkbpsk7k
         pjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745955000; x=1746559800;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/retCIRztlEpXR/AW2peSfIyedgB7T3xXb6E6WZilpw=;
        b=HOqMSQtQkawx2KaeetaPbEv3bOVNCy4CEX+7IrqvqON7oLkw0UBCE0GIDEu2h0TJUJ
         KA9blevKrNhxW4whaNQxZ5MnSS5TTIGA2jKUttzRRGgAidpC9mry4jdyL/Sx4enZul7W
         ON5FkNRc7PLFYlgqpiVsVu8r/d9yiSb9imNEFcS489wMhIJYL0LqIr9c1bqtmPatcvSB
         Mxt9EUQVaCyIVLsnXTpJ4AZ9rXGRrFZqlAPWZDHybxP8xabqANO8PYlmm3aTrqjwjWOW
         vZuQR3G/P4YDQQ2ZJk8TN9LP2CDJ03Oa9HRKxvkRvvWenYwn/PEZg0jQBWyzb8Ov3UNq
         LMGw==
X-Forwarded-Encrypted: i=1; AJvYcCV3VhXlU6ipKSs0gFhFVaiFrDPZlgQPbkBDySwWEELuMoEn9TCEic4BMgZ6yn8ubi+t19M=@vger.kernel.org, AJvYcCWUzK1hf7XU5ZndgUaM65EgkMh6b2QsLhUJCYVInYG+huhB5McHWcG1/4qG8FFG1J5JmwNtYOIPcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK5bSUY3VKx3a9SMaZfHebECMuNSF4BsLXc+SQRpmzQ3UN/7ts
	UoQmYr92YQG1uVruOm1o7yL/3W1LOEzTbYfPEgw0aUfGxKQhX+YB
X-Gm-Gg: ASbGncvr5Z/hI5v4fgpQ2rADckfIjYKj6yZCTmfqKASkQnGBrdnZ+KbIHuI1iUyX2zF
	x3tI6a02OQ0HuRlJ36UJTp/NM7gDrZEaOlIlSlC32MnbmZ4/3o0ytKTKdwzezy+jM/RQAcf5z7S
	jANBvtWB2+L4zaVVelTI6VPvqZaFpmkrUHWJjVD61P/jyxN72q/nB+OEXkDuY9ds4lrCxe/TPlS
	t0Ph2JA8Hl6/e9PySSycw5rjMwA4mhcyuLgVDwoHmyJkKdOUMLGPdUmokvyybUWwJybVvUDHAc7
	2x1nEr7ZCiQ8pTehC/skRDW2RZuaQMcURts58i6qz0Yi5RH+cA==
X-Google-Smtp-Source: AGHT+IGIX0a6rqbJ8BSwM7ITPErcIjX0NTczwan53p2658Q5u0I46/zqfK2f24hBwiP+qezhf0tqlw==
X-Received: by 2002:a17:902:e94e:b0:21f:1549:a563 with SMTP id d9443c01a7336-22df34a621emr7365395ad.2.1745954999809;
        Tue, 29 Apr 2025 12:29:59 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:8cbd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbdad6sm106548725ad.93.2025.04.29.12.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 12:29:59 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,  Arnaldo Carvalho de Melo
 <acme@kernel.org>,  Alexei Starovoitov <alexei.starovoitov@gmail.com>,
  Andrii Nakryiko <andrii@kernel.org>,  Ihor Solodrai
 <ihor.solodrai@linux.dev>,  bpf <bpf@vger.kernel.org>,
  dwarves@vger.kernel.org,  Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: pahole and gcc-14 issues
In-Reply-To: <CAEf4BzZgQMV+Gtiob_K-uuizyuqajyLjnGbKOJLyiGB=DxmY2Q@mail.gmail.com>
	(Andrii Nakryiko's message of "Tue, 29 Apr 2025 08:37:07 -0700")
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
	<076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com>
	<CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
	<4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com>
	<CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
	<c8c4dc05-7fa3-4c1f-a652-a470dd6985c7@oracle.com>
	<e279abde-f4c1-42d2-bcc0-4df174057431@oracle.com>
	<CAADnVQKi4DARfzQJguZyDQsfXHq7A=QM2FwRwpZe-LJzj+Ujrg@mail.gmail.com>
	<CAEf4BzYt2sUxRPAR5AbAAXVcOeC2UqgkR24WDEZAAd+kEz=g-w@mail.gmail.com>
	<CAEf4Bzays+8g7kj4fNS0rBLPTQWzYb_maFkyHyij4ky1xm_GAg@mail.gmail.com>
	<CAEf4BzZgQMV+Gtiob_K-uuizyuqajyLjnGbKOJLyiGB=DxmY2Q@mail.gmail.com>
Date: Tue, 29 Apr 2025 12:29:57 -0700
Message-ID: <m2ldrihikq.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

[...]

> Ok, so sleeping on this a bit more, I'm hesitant to do this more
> generic approach, as now we'll be running a risk of potentially
> looping indefinitely (the max_depth check I added doesn't completely
> prevent this).

Is that different from what happens already?

  /* Check if given two types are identical STRUCT/UNION definitions */
  static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id2)
  {
          [...]
          for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
                  if (...
                      !btf_dedup_identical_structs(d, m1->type, m2->type)) // <-- recursion,
                          return false;                                    //     afaiu it is unbounded.
          }
          return true;
  }

E.g. adding an array to mark visited types and stop descend should stop
inifinite recurusion. I agree with Alan, the patch you shared in the
evening looks interesting. (But it was butchered by gmail,
fixing patches by hand is a bit annoyiong, maybe just attach such files?).

[...]


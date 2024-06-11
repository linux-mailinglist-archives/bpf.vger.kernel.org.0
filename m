Return-Path: <bpf+bounces-31892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD99C904648
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 23:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4931F24886
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBA8153BE4;
	Tue, 11 Jun 2024 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BMpd+8HG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C6B15382E
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718141738; cv=none; b=mwyAOQdxQC8Z+VfMwUmsHvGjpQAeaj7199X9peXf6vPyweL1SYQxaWJI4z/WX3bl4+asPHX2e1p+G3mkVHkNfiPlomrHk+2dT3vLZqtzDlq6lJ0I4cbloDOVIplmzs3ejLYcNAaLUV5InEVWjBZJKYvClnjmpOon7ADr4HRFeDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718141738; c=relaxed/simple;
	bh=1z7srA7osNJj1aYJV58/IFOWkAWvG4t7SgHfg4hwbX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/10aJBMo4MLanFph22QilSWAyHFFLGSpXhSD6ldpSKog8uiEy85yKgXLcsRi+oAIaGeAwwvbrGe8ziU0lz2CKei3LcRjPKXh9buQA9m7nVIr95K0fkvr0gIYv6ePDflMUXMVH6MPQ6H8Nlcz5yquHLAbzJF+d1bJEm/B5O3wxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BMpd+8HG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so741475066b.2
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718141735; x=1718746535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kgwu43FUzPY5K/8QMmjEzl3qbHR+MSkeROUYSgbHmjU=;
        b=BMpd+8HGSVci/bvo/TELwtJ096TtX+RREukDwpORR5yH9+WtR4P8pJXE/cWBdNxZnJ
         1RI9QfqTXPb9ccW4FkWW0NPEI/w/O+hrLOMxTKxH4RVE9Umyv2X7JjZeIr2BM2JZUJSL
         aSjnvVSMd/4RGOf2FFoyr6rVILPCMYXsR2xx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718141735; x=1718746535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgwu43FUzPY5K/8QMmjEzl3qbHR+MSkeROUYSgbHmjU=;
        b=bpSVZdVLYmEKeRRGne0CmYPDPaMHAZ/bVeHsuaKmWGCDzo3wjg8aPe+bO4S+BXY/2s
         aBzAhhiYxFBRSu3RVcWWVDjt20ctLlg5bu4gXNgthJrEyZV7/laWaWq8d/F4Rsu74A+c
         PxnK5nUTHgFcxoshGDsd0XItoJMTTwbXLgJcRmIeNsSOqr9vgt8GS6YPjBdI51ucBUAp
         8NvqlseZOF3mvXXMpHI1jB1i3W8p1aEhBuRYomg6PH8GTUMgssaOOFUTEhDlzIfxTqEx
         8c9G1PyqkaiOK3iEDgX7W9TaWGWK5flobUekAOr8z0am8P3RqswmYjGI4ran/R7GLSxg
         BoCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEF9r01jMnZxZkNqBbI+iq8+aCPVoXrYxGVNoWRO+zK57WmnGIy6NjeRdE+Da5CB4KpvoMR4P8NqUI5z4OzCR93jpO
X-Gm-Message-State: AOJu0YycwqhLw3y891PYYXFLnzFTdZGM67H09sismIfkVsbmRVdASn9p
	5ZsxXsLlKC0EfVc9KWD1EgdJtGlAWOjCQBIdPoYSFf2upAQuRDdu9JXIIQYuxHV5h44s9ZaM6ID
	YZ8of1A==
X-Google-Smtp-Source: AGHT+IF9ZUhV3cJJyfsQ6iqE4OK7uSJn16JZiR516ZFb5/EjH3cpwKNIQ0XL7hGb04qGijJKZiIO1w==
X-Received: by 2002:a17:906:5498:b0:a6d:ee51:793b with SMTP id a640c23a62f3a-a6dee51911cmr720229966b.73.1718141734894;
        Tue, 11 Jun 2024 14:35:34 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6e23c9f22asm634070166b.171.2024.06.11.14.35.33
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 14:35:34 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35dc1d8867eso4864057f8f.0
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 14:35:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHfAO1e1orvC4pKhFMCZL+2Kf5UvJ2OBth0CmAF89Te3oGEsHaLWTIYzCzkO3cJtrgK9B4yUSdsVp+aD++sNvor112
X-Received: by 2002:a17:906:191b:b0:a69:2288:41da with SMTP id
 a640c23a62f3a-a6cd6665bc9mr812670466b.30.1718141712971; Tue, 11 Jun 2024
 14:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501151312.635565-1-tj@kernel.org>
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 14:34:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
Message-ID: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Tejun Heo <tj@kernel.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

[ Tejun reminded me about this, and discussion hasn't really gone
anywhere for much too long, so now I just need to be the person who
makes a decision and people can hate on ]

On Wed, 1 May 2024 at 08:13, Tejun Heo <tj@kernel.org> wrote:
>
> This is v6 of sched_ext (SCX) patchset.
>
> During the past five months, both the development and adoption of sched_ext
> have been progressing briskly. Here are some highlights around adoption:
[...]

I honestly see no reason to delay this any more. This whole patchset
was the major (private) discussion at last year's kernel maintainer
summit, and I don't find any value in having the same discussion
(whether off-list or as an actual event) at the upcoming maintainer
summit one year later, so to make any kind of sane progress, my
current plan is to merge this for 6.11.

At least that way, we're making progress, and the discussion at KS
2024 can be about my mental acuity - or lack thereof - rather than
about rehashing the same thing that clearly made no progress last
year.

I've never been a huge believer in trying to make everybody happy with
code that is out of tree - we're better off working together on it
in-tree.

And using the "in order to accept this, some other thing has to be
fixed first" argument doesn't really work well either (and _that_ has
been discussed for over a decade at various maintainer summits).

Maybe the people who have concerns about this can work on those
concerns when it's in-tree.

I'm also not a believer in the argument that has been used (multiple
times) that the BPF scheduler would keep people from participating in
scheduler development. I personally think the main thing that keeps
people from participating is too high barriers to participation.

Anyway, this is the heads-up to Tejun to please just send me a pull
request for the next merge window.

And for everybody else as a "It's happening" heads-up.

[ Please just mentally insert the "IT'S HAPPENING" meme gif here -
because if I actually were to include it here, lkml would just reject
this email. Sometimes the anti-html rules don't work in our favor ].

                Linus


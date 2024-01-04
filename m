Return-Path: <bpf+bounces-19012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445BE823C36
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 07:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F865B2387C
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 06:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6D81B268;
	Thu,  4 Jan 2024 06:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajN2rPAp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2868D1DA27
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 06:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3367632ce7bso123566f8f.2
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 22:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704349417; x=1704954217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahFVcq31IOR1HEzKt3oZgjHfmB2xSrMzPAXoNTycJyQ=;
        b=ajN2rPAp+MjprXGdRSMFP7lQqp4xJOR4hZpK5TjZlF0J8rrGCKTPwp1rsLnV+T9vIO
         +Rr+7r2yalh3fUo99oFXcp9I979HpzoZzU+J5fjV/7+JSl5Y3/3tuyyDcN0k0goANkhA
         28b5E9IK8SDgrZPrf3D/YNckplZKDAr/vokW23Azac/8ucRkqsyt51rdE1LjnNzrtG14
         HJiC4KOfDUzonnd4Fkg7DMINzNRkhoqVK8Wx6n3VI8SYyX9bzB+xXfoOhYza4J7mZQ6F
         sHxSNA9LYuZC7QR/xhQT7iG23529Jm8x+bfsK/VaTrVN/ln/B5pj+HllhijLdhzQmOep
         Gvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704349417; x=1704954217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahFVcq31IOR1HEzKt3oZgjHfmB2xSrMzPAXoNTycJyQ=;
        b=jBn19OomBFhrf6Jf74UIswfoArphm0dMrLQ00CUAkbNWV4wfQevC1+wOkBKhqGkE27
         H6FUGakEGtBMWWivV6AMnx9fF3c9E664/qIiCbKKRvFMDVlBDhmhZfPVW+pHyoO2wKMm
         3afAAYAQ2cS4vYqKYNs6fo+PAdgZvzcyRQAkAmHiJMTn/SS6H38UP2EsuVt84x/Qogow
         khofizA6xBZCyLh+b6Tr7UOZk/d7ZMABW6KR1Kaps/vSZmhzDAKQSqa2aY9L1yWttrLY
         cbGBL0A2LO4KAmduvudgsr+XmvcZWRq05aiYJC+2LcrpRIl3Ra0jlPnGOE7CzdUnXkiW
         WNMA==
X-Gm-Message-State: AOJu0Yzvm0OTgahXIW5njKEgfH9Bi74tYdSCzoqFa59D0jNzDPZt9uMU
	mQCodf5+KqVXf/4jHVKRIVjtMtmRRD1dxMgDeho=
X-Google-Smtp-Source: AGHT+IEjU4kq04Sc/ve1yLP3tZh84RKiTIBc2gx/7QFY+J762u1ipUqQSb4UWtGKCjHq/NKTH/YQfQ5Zlw7Hx5ydQ3Q=
X-Received: by 2002:a05:600c:46c3:b0:40d:5c83:c759 with SMTP id
 q3-20020a05600c46c300b0040d5c83c759mr69794wmo.18.1704349417340; Wed, 03 Jan
 2024 22:23:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011152725.95895-1-hffilwlqm@gmail.com> <20231011152725.95895-3-hffilwlqm@gmail.com>
 <ZYQpTm9SmTkGBNI0@boxer> <41187e00-7644-4974-90c8-cd8c499b7f9e@gmail.com>
In-Reply-To: <41187e00-7644-4974-90c8-cd8c499b7f9e@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Jan 2024 22:23:26 -0800
Message-ID: <CAADnVQJD-ep3c0EOfeGbdSGnQOnzHjajwk7KXqiK3P2Zu7npnQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/4] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 6:56=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
> >
> > but it is a must to have a better commit message here.
> >
>
> I'll write a better commit message here.

Please respin with updated commit messages and drop RFC tag.
Keep Reviewed-by that you received already.


Return-Path: <bpf+bounces-17827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D41A8131C4
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 14:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2E02833D7
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BCA56B72;
	Thu, 14 Dec 2023 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQAQ5R5b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB48B111;
	Thu, 14 Dec 2023 05:37:59 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3364a5ccbb1so394137f8f.1;
        Thu, 14 Dec 2023 05:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702561078; x=1703165878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNWLUH9LK89TjpgsuyNt+Vo/yCFW7ydehD3FUtjWpIE=;
        b=TQAQ5R5byzbgtG87t4sKZ3cri5njjwPnP2Unl25p1D6Zsx2IExilf1vM9UIcZM67YK
         Ua4v/vrc53QNx1DvKuZwyulmDm/7+eYtAXCBZhvlKbukeG6rtBxB0YO+oi9ZUwEO7ZWk
         yP31SjZIQeohsrQIM5UaiIa61cN5cAdhDXtv54IJ7VPX/+T8vJbFNeSXe7PfWhHdZaYS
         ZChZ8Y+4UBpe4FD9c9cvIgdQFMdHNkU2ENx+u8y4GKP8jbXsb5Exk9OeaDQE0lMy+syS
         hCk7JF1Nn2merkSgf8TErvakamyNK2K6BxVzGlTnQF6n0whOt4S2VV3qNegilth3S+eA
         oJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561078; x=1703165878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNWLUH9LK89TjpgsuyNt+Vo/yCFW7ydehD3FUtjWpIE=;
        b=iM6Zfph1hdxvC7W+RznZz209XVLQNvO2YDYuGXt7C+vgHZ7EUroueXnaGm4Pb/82D5
         AX0kb4J7dVH/uohrRObk21z2fID98llTihpFpXziEFhivCTHELHkJAvh3plBym3CDTcW
         1GCkwa6bSVBmJkbWS3q/9KTDDhuxFAGcOA/zgXYqcH6slsEcYoUa8gKw3mLGpwuuACYC
         lwYhz0WYv4e+dmXRoc+0h7u/Fa1gE51ni+T2eWJhmZJD9dSPtMOdwOJTzu+Vk6+AMnVi
         I6yAGPsMy3R5vYhnAAkhwE0fiThJf47meH9R64zilrIP6Mx8X9ngNAUZ+ERc6uO7seeQ
         NbPg==
X-Gm-Message-State: AOJu0Yw6iyqIe+I+DQrkhmc5rfXhsznQC+aWYbV9ecJHTnuHKOpi36G1
	T5Zm8x2rXQf0vsS6Aa+KHIJFqs3gBTZNFFzXbbA=
X-Google-Smtp-Source: AGHT+IEmT0ADDFMybjWYEPYJY+YvMwwkfq+XWFrFSF3mYc+Q8NtVmej3eqMgHssryjklGKikaFiVw/ij7KjfMs8gvN0=
X-Received: by 2002:a5d:6e0c:0:b0:336:957:2aec with SMTP id
 h12-20020a5d6e0c000000b0033609572aecmr5042155wrz.100.1702561077886; Thu, 14
 Dec 2023 05:37:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com>
 <1702467945-38866-2-git-send-email-alibuda@linux.alibaba.com>
 <20231213222415.GA13818@breakpoint.cc> <0e94149a-05f1-3f98-3f75-ca74f364a45b@linux.alibaba.com>
 <CAADnVQJx7j_kB6PVJN7cwGn5ETjcSs2Y0SuBS0+9qJRFpMNv-w@mail.gmail.com> <e6d9b59f-9c98-53a1-4947-720095e0c37e@linux.alibaba.com>
In-Reply-To: <e6d9b59f-9c98-53a1-4947-720095e0c37e@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Dec 2023 05:37:46 -0800
Message-ID: <CAADnVQK5JP3D+BrugP61whZX1r1zHp7M_VLSkDmCKF9y96=79A@mail.gmail.com>
Subject: Re: [RFC nf-next 1/2] netfilter: bpf: support prog update
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	coreteam@netfilter.org, netfilter-devel <netfilter-devel@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:57=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.co=
m> wrote:
>
>
>
> On 12/14/23 1:50 PM, Alexei Starovoitov wrote:
> > On Wed, Dec 13, 2023 at 9:31=E2=80=AFPM D. Wythe <alibuda@linux.alibaba=
.com> wrote:
> >> I will address those issues you mentioned in the next version.
> > Don't. There is no need for the next version.
> > None of these changes are necessary.
>
> Can I know the reason ?  Updating prog for active link is kind of
> important feature
> for real application..

yes. it's and it's working as expected. Do you see an issue?


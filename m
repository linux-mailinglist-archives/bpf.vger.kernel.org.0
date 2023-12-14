Return-Path: <bpf+bounces-17853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92534813596
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 17:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB8282CCC
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36925EE86;
	Thu, 14 Dec 2023 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B83aglsQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A84112;
	Thu, 14 Dec 2023 08:02:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3364c9ba749so90002f8f.1;
        Thu, 14 Dec 2023 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702569756; x=1703174556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ41hRFDTPCl36L/OqktX81t/pEtH3ZPe1LqX+mZtmE=;
        b=B83aglsQpJkeyf95kr/c8P9g/97iIOlfAjxWXd8rCoL008jUmTMEzLITPe0rkCdTNy
         wJThJ9ptv/qxVsuhd5+3j75THQAprWQbZNE4/eLG7O7J7jFTM0jUeRf9U2WfvckI3156
         P41zflFZpSNj+vC9UEYctGBNVYPzq/A3wbZW3vm0leBPT5OGQZJbLBGH9Ek55ITRYVEZ
         l1kBf/78bCy2fOYX2Kh3saTAQ9g/GGKGgan+tlZU5WuwLuGtGIas0y1AI8qhq41gjBjb
         +qc0wZK10HEO6SF3P6I4U/CjnPnN2vsZ2vqoUgVnTMV7zt+pMhe7cbENjoGVjtO8Kv0J
         BnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702569756; x=1703174556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJ41hRFDTPCl36L/OqktX81t/pEtH3ZPe1LqX+mZtmE=;
        b=Y+miku/UgpFx+QG0Lg744//emwN20Bp+m3c4hxihrAi05UKPHNjMv5cHA7+xnrGkY6
         3JO0lLn14fRrNPxMStBqRuvDF15rfpCPvIqOi7A//bsU6O1UWJxwLs3NJdVjPEETIlEk
         UEX4xqg+QJzhGC+6W3FSvq5h8Cz3yfLQhsDw9q+pvydnCYLRYzjkWb2C6mrzPK/nvvUe
         Vyb5nyQyW76km5Az8LRH01c7JLFHyHwUtChRCWZ6fHoff8UN4m/VEAn6CndaQEnO5nzd
         mH3piWGYwgFaMo8dWy690VGsj+7s5i+LV6Em6fdpGsMM+OSlmOuq0QAQ7zt0z/O42wLL
         9l2g==
X-Gm-Message-State: AOJu0YzKihww5SBUtLPs2M6ounMh92/ESzB5kYrz2/Az3KH9W5p14Nls
	8+DhmEULBaqYtFm0IjG6ul9CJcVVWxE3XJ0lGaA=
X-Google-Smtp-Source: AGHT+IG7hWZGSx21e/13fUXWOAKTNGA2NvhpJZ2IgjJgkPCIQP1yknBGnqK36ufv81S3Ewk8SDCkhs+5XZC+8MyH8KI=
X-Received: by 2002:a5d:4982:0:b0:336:460b:fb87 with SMTP id
 r2-20020a5d4982000000b00336460bfb87mr375568wrq.169.1702569755351; Thu, 14 Dec
 2023 08:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com>
 <1702467945-38866-2-git-send-email-alibuda@linux.alibaba.com>
 <20231213222415.GA13818@breakpoint.cc> <0e94149a-05f1-3f98-3f75-ca74f364a45b@linux.alibaba.com>
 <CAADnVQJx7j_kB6PVJN7cwGn5ETjcSs2Y0SuBS0+9qJRFpMNv-w@mail.gmail.com>
 <e6d9b59f-9c98-53a1-4947-720095e0c37e@linux.alibaba.com> <CAADnVQK5JP3D+BrugP61whZX1r1zHp7M_VLSkDmCKF9y96=79A@mail.gmail.com>
 <3c1f3b68-f1fc-495c-5430-ba7bc7339619@linux.alibaba.com>
In-Reply-To: <3c1f3b68-f1fc-495c-5430-ba7bc7339619@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Dec 2023 08:02:23 -0800
Message-ID: <CAADnVQLJ3XkZMQDdMGOcKUqK8xuFHcc1+74o6RrzfzeZo7v28A@mail.gmail.com>
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

On Thu, Dec 14, 2023 at 7:56=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
>
>
> On 12/14/23 9:37 PM, Alexei Starovoitov wrote:
> > yes. it's and it's working as expected. Do you see an issue?
>
> Hi Alexei,
>
> I see the issue here is that bpf_nf_link has not yet implemented
> prog_update,
> which just simply returned -EOPNOTSUPP right now.

I see. The commit log didn't make it clear.
Yes. That would be good to support.


Return-Path: <bpf+bounces-17785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8317181271E
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 06:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2CF281D2F
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 05:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A3B79C5;
	Thu, 14 Dec 2023 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HokT50fZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F063CBD;
	Wed, 13 Dec 2023 21:50:43 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so1072255e9.1;
        Wed, 13 Dec 2023 21:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702533042; x=1703137842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gv2LMH04lN7pN5hZISqbYob6Kor2oYpqw6+JDkjEriQ=;
        b=HokT50fZc9RVfykcVNPB7MAMiIfFslOIq+/7xkMeoYnRyHEUSAOprgImDyVV0D+tRH
         s/j2/iHWnicQY0JdgWy9xrfISNNJPfB7AA2D5xnt9paIdCDsiXfbJvYtj5sCpRN3F1yV
         yuKgOcCiFVJu1kzGBsHX3C4S+p9NYjoKdPHHUc9PmoumoiicIv+vh01EsOlGsE29/Lie
         4om1HMaPN+3a/gnbjj0oqOmDKI7P0j4Ymyh3hT8spP3+/NgT89LtC7Fc4UMQu2pkWzgl
         bIBdp+PrvChkDYNY3FFbrMStL6sGOuhIkL1Ut4nhG1yuCMz5hVEHGE71QiHt1X5s9h5U
         mD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702533042; x=1703137842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gv2LMH04lN7pN5hZISqbYob6Kor2oYpqw6+JDkjEriQ=;
        b=DJB78LHTNAa3xsdg5etBLSvAkhcEk7yFkE5NabO7TjkziVWvUQbc/xisZtn7wA7qUa
         4H20yFwclFE2LvypG94YkmSeO1QqvEPyik+7m4Ww3tUAbGEmis6raxdj5cPbuKE5nz0K
         /TEzSzkvISYkz47IF6BqWBNO5tnS4Bzm9SqbI18ED/7JmsQwOoKT68GhAo3pTPTZaxYt
         SUHg2Be5VDnCca26GFPqjNiFMsAhigccBTCLdifWFiOYLdt7ItchfvFpCAa863QWynoa
         HBQYFnGzHRvm2RT6iWLa6qdCPbBXXAZu+JVdlC0SiD2N/tltYscQxGqk7QigUTbA4Grp
         aA6A==
X-Gm-Message-State: AOJu0YwZAnZNlK1zHwuYpBCs+shSTs9alNfBSqwzcB6j4XjD1+YH0NAq
	oS5DACzHAtpj2XB/9FLcID2ejS6Gzqb8MaUR7Gs=
X-Google-Smtp-Source: AGHT+IG8HTlkBLhPbgrHweb+oxh/HFdECRuBkFiUukTeyqSmIqt3mDI0jXGTMa2gff001mk6v1A6Y271QBqB28KxA7s=
X-Received: by 2002:a05:600c:3784:b0:40b:5e4a:235a with SMTP id
 o4-20020a05600c378400b0040b5e4a235amr4169222wmr.92.1702533042008; Wed, 13 Dec
 2023 21:50:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com>
 <1702467945-38866-2-git-send-email-alibuda@linux.alibaba.com>
 <20231213222415.GA13818@breakpoint.cc> <0e94149a-05f1-3f98-3f75-ca74f364a45b@linux.alibaba.com>
In-Reply-To: <0e94149a-05f1-3f98-3f75-ca74f364a45b@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 Dec 2023 21:50:30 -0800
Message-ID: <CAADnVQJx7j_kB6PVJN7cwGn5ETjcSs2Y0SuBS0+9qJRFpMNv-w@mail.gmail.com>
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

On Wed, Dec 13, 2023 at 9:31=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
> I will address those issues you mentioned in the next version.

Don't. There is no need for the next version.
None of these changes are necessary.


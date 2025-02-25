Return-Path: <bpf+bounces-52559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C027A44A5E
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 19:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5223BA7AC
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F4A19F471;
	Tue, 25 Feb 2025 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3Ek/dFm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7F19FA93;
	Tue, 25 Feb 2025 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507521; cv=none; b=ccvf1JKafc65pgtL3au/9joqmraXceFoyh6rq87tdwgnRhuy+auP2FY3YtcgyewsGYm7Cxx4cFnPnBmCXpR8OY7XdjGmINpv9umozv51iFme1cNSYRqhHahpMzO2UBdwAICWBi3eFcPa0Xhpe8/AKz5BfaVa+ERS021BFIt7CNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507521; c=relaxed/simple;
	bh=nSmcu8mBDByg1ccnSABwPSDNfGlYfV/XDsHta8xmrzY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Saqg+tA3iTxP8uou6yZWn2W2fLWa0DQ7E25i/Pv6HCqGWG/H6JlIqmOZ5UIM0xkCVUnyYvtX1N1aTekKIMbxVsM3ds3+xFkNHH1b6X/FcLfDa+hrLdRdFW9aPbcFCzxwZ86uumA0K3feG9zBUT1KNLJ2H+G3Dk5yxxAHn9DFgV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3Ek/dFm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-221206dbd7eso124662635ad.2;
        Tue, 25 Feb 2025 10:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740507518; x=1741112318; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NtQTfON/JiuecP4GIgm7PFLvHNC8mTg0/kCN2xc7bjc=;
        b=c3Ek/dFm7VEBwRLDdbq2RWROGC0qYrdARupb3Br4C7OF6DIeR13sCBgTh/oS9/j8vC
         +bIkxnW29mLRU1V/nf9nOn46ieXRTNxEkFLYwdR5bZyr0iC1hDKwZb30IbjSaEBcviGA
         9Hm6ZJrVWLymeWBbeSp3zyONrG6WXgkdR34IV33uLibfyr5TbRViJsTkFF3cGKM8r+wD
         QT0bwcq5DRBRPfJhsAcif3uZ5xAAnX7pQ8eCegRpDEPewPDFIgVusxQU2JqYSR/0SS53
         lF0eCdaa1hIbSxhItkgcqd231WgYOMkquVuEVR8FGOpaM7x4mbtK5ykpCU20fTU5T/+Y
         cHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507518; x=1741112318;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NtQTfON/JiuecP4GIgm7PFLvHNC8mTg0/kCN2xc7bjc=;
        b=X5jKISZvWxfRpVNH4TIpiQmNDqxotdqHZnuN4UQQZjNsdA4Dk/6gB8GGkszLfdOhG1
         1cW8VnthGwfNhfAY2jH2y4N96ZCgRrOSQXbmEN4krTCybH+soHb8Cvjfdxc90rhVob0N
         VWtuGF3YbPoRNF9HuNLazgQY/7FJepcL3shDhy7n1aVgOBWYlM6tG2sZSbzdiqzojFJ4
         641Ucx35k53wgnK7V9WdAF+W/WosMD+nIzjtvvP4UcUTdkOBJIWHqq6XPsRF+D9+kJ/g
         Izoy8ytNALevhTkDHrz4K4O+m73NoTRfWUY6Q9ke/Rx4EFgOFRLEoozF88ThO7aQxvz0
         kPEw==
X-Forwarded-Encrypted: i=1; AJvYcCXfXbD1KQ6N2snGO9jFuO6hLLtCcQYOqss/l9is2e8HYqQmFy8U30jsxxeQM8uUS8BWfTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAuApHgZyFoOpcmX6vaMzrH1JH2gMo/Ft4kduFvWi6s2svweav
	4ZYNLsnNG3zlaWffpEh/fdlJH4Q+dbYaKKkEtEaYPQgq8alKS5fBgzkJHw==
X-Gm-Gg: ASbGncs0NX+KGB7NxdyqUV/Caif2rlqjn8sKOtTpF8cBs/dIFZHJgIEBr07si1u/Iww
	Q2jyEgLZ82EgBLDwh3B+OIV8eAJ4V+uZieeZnn9+k9TIrJnEjHZxC5SDU4MIMLn7nTBE0bH2w6w
	nGzeXGsdcrXOsITIsZvxER0FxIavWKRgnWDokh0gb0A7Yk9CZ7KuPtevKQIsO+iozrn4jk5bfyA
	tdCl20GVoo72eZSdc1wVufguPd6qY+CSbz5Wx5M5qZOi2aKPJ6e/leiulXglBsOywrSEb7w1W+I
	MpgkRBzPYPzTv+1bV6GDvXo=
X-Google-Smtp-Source: AGHT+IGOgX/hrmQglUdhQA/3OwFYvhuRosVSI7mDf9cu2ptejJU2gzIj5Yq0/R5qCjfeJdWZO30ZLA==
X-Received: by 2002:a17:902:e5cd:b0:220:e338:8d2 with SMTP id d9443c01a7336-223200a12b5mr5233855ad.21.1740507517925;
        Tue, 25 Feb 2025 10:18:37 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f8272sm1883003b3a.109.2025.02.25.10.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:18:37 -0800 (PST)
Message-ID: <0be6d9153b6684331356231cc11b8d3afa5fc98e.camel@gmail.com>
Subject: Re: eBPF verifier does not load libxdp dispatcher eBPF program
From: Eduard Zingerman <eddyz87@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Chris Ward <tjcw01@gmail.com>, 
 Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	 <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Ward <tjcw@uk.ibm.com>, 
	bpf@vger.kernel.org
Date: Tue, 25 Feb 2025 10:18:33 -0800
In-Reply-To: <20250225-gay-awesome-copperhead-502cd2-mkl@pengutronix.de>
References: 
	<CAC=wTOhhyaoyCcAbX1xuBf5v-D=oPjjo1RLUmit=Uj9y0-3jrw@mail.gmail.com>
	 <CAC=wTOgrEP3g3sKxBfGXqTEyMR2-D74sK2gsCmPS2+H-wBH6QA@mail.gmail.com>
	 <20250225-gay-awesome-copperhead-502cd2-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

 Skip to content [79]=20
Navigation Menu Toggle navigation=20




[80]=20
Sign in
[81]=20
*=20

Product













GitHub Copilot
Write better code with AI



[37]





Security
Find and fix vulnerabilities



[71]





Actions
Automate any workflow



[72]





Codespaces
Instant dev environments



[73]





Issues
Plan and track work



[74]





Code Review
Manage code changes



[75]





Discussions
Collaborate outside of code



[76]





Code Search
Find more, search less



[77]




Explore


All features


[35]

Documentation




[22]

GitHub Skills




[26]

Blog




[15]



*=20

Solutions







By company size


Enterprises


[36]

Small and medium teams


[40]

Startups


[69]

Nonprofits


[70]


By use case


DevSecOps


[65]

DevOps


[66]

CI/CD


[67]

View all use cases


[68]




By industry


Healthcare


[60]

Financial services


[61]

Manufacturing


[62]

Government


[63]

View all industries


[64]




View all solutions



[78]=20

*=20

Resources







Topics


AI


[55]

DevOps


[56]

Security


[57]

Software Development


[58]

View all


[59]




Explore


Learning Pathways




[51]

Events & Webinars




[41]

Ebooks & Whitepapers


[52]

Customer Stories


[53]

Partners




[30]

Executive Insights


[54]



*=20

Open Source











GitHub Sponsors
Fund open source developers



[50]






The ReadME Project
GitHub community articles



[16]


Repositories


Topics


[47]

Trending


[48]

Collections


[49]



*=20

Enterprise













Enterprise platform
AI-powered developer platform



[36]


Available add-ons






Advanced Security
Enterprise-grade security features



[44]





GitHub Copilot
Enterprise-grade AI features



[45]





Premium Support
Enterprise-grade 24/7 support



[46]



*=20
Pricing [39]
undefined
Search or jump to... undefinedundefined=20
Search code, repositories, users, issues, pull requests...=20

Provide feedback=20
undefined


We read every piece of feedback, and take your input very seriously.
Include my email address so I can be contacted
Cancel Submit feedback
Saved searches Use saved searches to filter your results more quickly=20
undefined




Cancel Create saved search

Sign in
[81] Sign in to GitHub Username or email address Password Forgot password? =
[82]=20










Sign up
[83] Reseting focus=20




404 =E2=80=9CThis is not the web page you are looking for=E2=80=9D=20

Find code, projects, and people on GitHub: Search=20
Contact Support [84] =E2=80=94 GitHub Status [85] =E2=80=94 @githubstatus [=
86]=20
Site-wide Links=20


[80] Subscribe to our developer newsletter Get tips, technical guides, and =
best practices. Twice a month. Right in your inbox.

Subscribe


[87] Product *=20
Features [35]
*=20
Enterprise [36]
*=20
Copilot [37]
*=20
Security [38]
*=20
Pricing [39]
*=20
Team [40]
*=20
Resources [41]
*=20
Roadmap [42]
*=20
Compare GitHub [43]
Platform *=20
Developer API [29]
*=20
Partners [30]
*=20
Education [31]
*=20
GitHub CLI [32]
*=20
GitHub Desktop [33]
*=20
GitHub Mobile [34]
Support *=20
Docs [22]
*=20
Community Forum [23]
*=20
Professional Services [24]

*=20
Premium Support [25]
*=20
Skills [26]
*=20
Status [27]
*=20
Contact GitHub [28]
Company *=20
About [13]
*=20
Customer stories [14]
*=20
Blog [15]
*=20
The ReadME Project [16]
*=20
Careers [17]
*=20
Newsroom [18]
*=20
Inclusion [19]
*=20
Social Impact [20]
*=20
Shop [21]

*=20
=C2=A9 2025 GitHub, Inc.
*=20
Terms [8]
*=20
Privacy [10]
(Updated 02/2024 [9])
*=20
Sitemap [11]
*=20
What is Git? [12]
*=20


Manage cookies


*=20


Do not share my personal information


*=20



GitHub on LinkedIn
[1]
*=20

Instagram

GitHub on Instagram
[2]
*=20



GitHub on YouTube
[3]
*=20



GitHub on X
[4]
*=20

TikTok

GitHub on TikTok
[5]
*=20

Twitch

GitHub on Twitch
[6]
*=20



GitHub=E2=80=99s organization on GitHub
[7]



  =20

[1]                    GitHub on LinkedIn        https://www.linkedin.com/c=
ompany/github
[2]          Instagram          GitHub on Instagram        https://www.inst=
agram.com/github
[3]                    GitHub on YouTube        https://www.youtube.com/git=
hub
[4]                    GitHub on X        https://x.com/github
[5]          TikTok          GitHub on TikTok        https://www.tiktok.com=
/@github
[6]          Twitch          GitHub on Twitch        https://www.twitch.tv/=
github
[7]                    GitHub=E2=80=99s organization on GitHub        https=
://github.com/github
[8] Terms https://docs.github.com/site-policy/github-terms/github-terms-of-=
service
[9] Updated 02/2024 https://github.com/github/site-policy/pull/582
[10] Privacy https://docs.github.com/site-policy/privacy-policies/github-pr=
ivacy-statement
[11] Sitemap https://github.com/sitemap
[12] What is Git? https://github.com/git-guides
[13] About https://github.com/about
[14] Customer stories https://github.com/customer-stories?type=3Denterprise
[15] Blog https://github.blog/
[16] The ReadME Project https://github.com/readme
[17] Careers https://github.careers/
[18] Newsroom https://github.com/newsroom
[19] Inclusion https://github.com/about/diversity
[20] Social Impact https://socialimpact.github.com/
[21] Shop https://shop.github.com/
[22] Docs https://docs.github.com/
[23] Community Forum https://github.community/
[24] Professional Services https://services.github.com/
[25] Premium Support https://github.com/enterprise/premium-support
[26] Skills https://skills.github.com/
[27] Status https://www.githubstatus.com/
[28] Contact GitHub https://support.github.com/?tags=3Ddotcom-footer
[29] Developer API https://docs.github.com/get-started/exploring-integratio=
ns/about-building-integrations
[30] Partners https://partner.github.com/
[31] Education https://github.com/edu
[32] GitHub CLI https://cli.github.com/
[33] GitHub Desktop https://desktop.github.com/
[34] GitHub Mobile https://github.com/mobile
[35] Features https://github.com/features
[36] Enterprise https://github.com/enterprise
[37] Copilot https://github.com/features/copilot
[38] Security https://github.com/security
[39] Pricing https://github.com/pricing
[40] Team https://github.com/team
[41] Resources https://resources.github.com/
[42] Roadmap https://github.com/github/roadmap
[43] Compare GitHub https://resources.github.com/devops/tools/compare
[44]                              Advanced Security         Enterprise-grad=
e security features               https://github.com/enterprise/advanced-se=
curity
[45]                              GitHub Copilot         Enterprise-grade A=
I features               https://github.com/features/copilot#enterprise
[46]                              Premium Support         Enterprise-grade =
24/7 support               https://github.com/premium-support
[47]        Topics        https://github.com/topics
[48]        Trending        https://github.com/trending
[49]        Collections        https://github.com/collections
[50]                        GitHub Sponsors         Fund open source develo=
pers               https://github.com/sponsors
[51]        Learning Pathways              https://resources.github.com/lea=
rn/pathways
[52]        Ebooks & Whitepapers        https://github.com/resources/whitep=
apers
[53]        Customer Stories        https://github.com/customer-stories
[54]        Executive Insights        https://github.com/solutions/executiv=
e-insights
[55]        AI        https://github.com/resources/articles/ai
[56]        DevOps        https://github.com/resources/articles/devops
[57]        Security        https://github.com/resources/articles/security
[58]        Software Development        https://github.com/resources/articl=
es/software-development
[59]        View all        https://github.com/resources/articles
[60]        Healthcare        https://github.com/solutions/industry/healthc=
are
[61]        Financial services        https://github.com/solutions/industry=
/financial-services
[62]        Manufacturing        https://github.com/solutions/industry/manu=
facturing
[63]        Government        https://github.com/solutions/industry/governm=
ent
[64]        View all industries        https://github.com/solutions/industr=
y
[65]        DevSecOps        https://github.com/solutions/use-case/devsecop=
s
[66]        DevOps        https://github.com/solutions/use-case/devops
[67]        CI/CD        https://github.com/solutions/use-case/ci-cd
[68]        View all use cases        https://github.com/solutions/use-case
[69]        Startups        https://github.com/enterprise/startups
[70]        Nonprofits        https://github.com/solutions/industry/nonprof=
its
[71]                              Security         Find and fix vulnerabili=
ties               https://github.com/features/security
[72]                              Actions         Automate any workflow    =
           https://github.com/features/actions
[73]                              Codespaces         Instant dev environmen=
ts               https://github.com/features/codespaces
[74]                              Issues         Plan and track work       =
        https://github.com/features/issues
[75]                              Code Review         Manage code changes  =
             https://github.com/features/code-review
[76]                              Discussions         Collaborate outside o=
f code               https://github.com/features/discussions
[77]                              Code Search         Find more, search les=
s               https://github.com/features/code-search
[78]                View all solutions                       https://github=
.com/solutions
[79] Skip to content https://github.com/tjcw/bpf-examples/tree/tjcw-explore=
-sameeth#start-of-content
[80]                        https://github.com/
[81]              Sign in            https://github.com/login?return_to=3Dh=
ttps%3A%2F%2Fgithub.com%2Ftjcw%2Fbpf-examples%2Ftree%2Ftjcw-explore-sameeth
[82] Forgot password? https://github.com/password_reset
[83]                  Sign up                https://github.com/signup?ref_=
cta=3DSign+up&ref_loc=3Dheader+logged+out&ref_page=3D%2Ftjcw%2Fbpf-examples=
%2Ftree%2Ftjcw-explore-sameeth&source=3Dheader
[84] Contact Support https://support.github.com/?tags=3Ddotcom-404
[85] GitHub Status https://githubstatus.com/
[86] @githubstatus https://twitter.com/githubstatus
[87]    Subscribe        https://resources.github.com/newsletter/


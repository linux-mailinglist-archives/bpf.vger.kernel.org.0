Return-Path: <bpf+bounces-56979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC795AA1C8A
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 22:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D15467E53
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 20:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F92826FD9D;
	Tue, 29 Apr 2025 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baBkNumo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ADE26FA42;
	Tue, 29 Apr 2025 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745960171; cv=none; b=EWKsErv0t6MHm5Pwlh7pEN1O+h5Sb01v2ldtSU412m+c/g8fB9D3/HfokRnmEGPu1SGCfuo8SU/QBgkJ+gsObaiD5wFzEmK3VJzCExvGu549KTqsJCV2zs2z/txXdt7pbA+HFxGgzl3oqb++jPhUm//5L2fTE2rruE5TcvL7/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745960171; c=relaxed/simple;
	bh=QiIFHt2bjcTfhL7pAplJy2TZjgDHR4pbuldcAfuRb1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLPMOzitUZdXo+h8D5J4fU4zKEirpgIzch7tl3Sj/Oo7iWfpLJk2VGyzOnhNYRvPkJ0a9byQVFG1paXtUwjU8MnBHgl1VGmZ7NI5SlQWQJB7vu4YXfo4NgTRLNfzNY6736ka/QQmD60Jie6Zakn0QUY7XM6ADR4+Rq3f1azoIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baBkNumo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so43077705e9.1;
        Tue, 29 Apr 2025 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745960168; x=1746564968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5F0qeBOsq9CE1hiB1Qr5EJ0CfI1jniAF1KATON5GvM=;
        b=baBkNumoQGNMkN1MSdA/UcdfTamX9xR9uf18bGuXVufgR589ckW97SX7vMwqO+auv2
         eaNaeQUQp5EJhXd/+riCEEXKHBlSdnrNxCo3dt1Gg5WSIo8jwMJ8w9LGQgZBFgHAmJbn
         Xba4vXEaiZMLmtDy8NAe9xtXvbgeLlEefYowsv0yvLz95PA4cCxdN4lAjCeI9ClfJypK
         R781Cf3KW/NdE8N2wH+8I6015/xLrXQKk1BkRXsWAgv6dbN3uX0fNsRh7HAB1adviY+p
         x8YN8dj8TooEmov8cez7462yffBuncazOtCD7N8N32exXXKqcFPEiy7Y0UA4A/SYdMzn
         lu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745960168; x=1746564968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5F0qeBOsq9CE1hiB1Qr5EJ0CfI1jniAF1KATON5GvM=;
        b=KXjYdC4RJ/OUOw7xOk5McXFtm21pefW9+pWoiy/bSSz4dTS+7Ru/ybnEnbNM3oDhjo
         9vR/R0TtsjRWdoj2NtDgwHSL7HMl+YgxzZJmxMmB0Ng7CZS97+aQhT+pv2mpRf36RHfD
         c4CFNJY0wk1Nn2OuYbL0svUWUbhBOIr2npQ3j+9w2Q043utkWwzAS0X8/TNwocuz3J1+
         kmEixqvsRRf3E0E1dE6DAsXuxpmFV7lgFJ2LPzbB/06s7YXTwQ6ang4CyP8kRHj1Yywe
         erY2IZqCeeFIaDqiIHIza5Ou5rhn4uCDu5gMtZVoIHRa9fgHUNhm6tcbjcbCyHpVWjiy
         H9XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8ifO2A9uFt7X0cA7cuzpmRUFOxybC8TcBxBjATBbD1jGvmPohb5I6Il46xv2QJmDA94=@vger.kernel.org, AJvYcCWkdjzKYe1kAuNhFIbYqUFePaBRTgFI2o6YOG8LqZqO5BJjovHuF6r4mOg8OkTNJ6QoMHDGbo4AWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUz2125QrFs8LmDw4zEHXdl3k7JlmYDbOKQom07a4AbM2/p9gR
	/FPJEOQyBzA2/0NZLSya4lLrV8AYpbZVqhRrCg3ys6H3G2Q2TP2Brk56gqtTcppT9avlxjzh5LO
	4+tSC7Z2ls1Z4wLi11TyCilR5IUmf/ABD
X-Gm-Gg: ASbGncsCFBYumXZ/IMfRMeJfglPzFpfkubLs4zPm7XzJANAkvhsNAuH08Do/Q0FQQJC
	ENPTTB7eBeWSCy3BxYzA4RrHziqZkSEkmNJdbzY8arfJ+FOf45rAsedTYOzUmJiFn2boHZ4o+UO
	OIH3sT3py5Z7aHnGCmZLLohq8EeVNJAlta6tbsEBRYv/0ZtC5g
X-Google-Smtp-Source: AGHT+IEOSLi2l3fC4qwWluR88CBHkYW463xJGtG3Vfu12fTWvqETP/18Meo8CrphGeZ5Odg0QJFf+hLGCoigPfE/0Xk=
X-Received: by 2002:a05:600c:540e:b0:43d:7588:6687 with SMTP id
 5b1f17b1804b1-441b1f35790mr6725705e9.12.1745960167565; Tue, 29 Apr 2025
 13:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com> <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
 <4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com> <CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
 <c8c4dc05-7fa3-4c1f-a652-a470dd6985c7@oracle.com> <e279abde-f4c1-42d2-bcc0-4df174057431@oracle.com>
 <CAADnVQKi4DARfzQJguZyDQsfXHq7A=QM2FwRwpZe-LJzj+Ujrg@mail.gmail.com>
 <CAEf4BzYt2sUxRPAR5AbAAXVcOeC2UqgkR24WDEZAAd+kEz=g-w@mail.gmail.com>
 <CAEf4Bzays+8g7kj4fNS0rBLPTQWzYb_maFkyHyij4ky1xm_GAg@mail.gmail.com>
 <CAEf4BzZgQMV+Gtiob_K-uuizyuqajyLjnGbKOJLyiGB=DxmY2Q@mail.gmail.com>
 <m2ldrihikq.fsf@gmail.com> <CAEf4Bzb_-Wk8eWZyPc7_r2Oq_o_Tgg+2CE+nTom2wOhjcpDw4A@mail.gmail.com>
In-Reply-To: <CAEf4Bzb_-Wk8eWZyPc7_r2Oq_o_Tgg+2CE+nTom2wOhjcpDw4A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Apr 2025 13:55:55 -0700
X-Gm-Features: ATxdqUEVGWJHDJgxYAjg7Suzm00tfE2ovEInyk9xWHoF_D61_PoSPVefxKxQF10
Message-ID: <CAADnVQJ3FYSVbjRKTs8NaPp6Gvq=HdrmDmf+=rP87TNJiSL2kw@mail.gmail.com>
Subject: Re: pahole and gcc-14 issues
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 12:50=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> But here you go if you want to play with it ([0]).
>
> And yes, "visited" marks are the solution, but I was thinking that if
> we implement a pre-processing deduplication step as we discussed
> offline, we won't need to do any of this, so didn't want to pursue
> this further. But we can talk about this, of course. So far this
> generality doesn't buy us anything, I got byte-for-byte identical
> bpf_testmod.ko with Alan's and my changes all the same.
>
>   [0] https://gist.github.com/anakryiko/fd1c84dcad91141d27d8bd33453521d1

I like it. I think it's worth following up with that.
Why do you think max_depth is not enough?
Because of
btf_dedup_identical_types ->
  btf_dedup_identical_structs ->
    btf_dedup_identical_types
?
Then pass &max_depth from btf_dedup_is_equiv() ?

The visited mark seems overkill.


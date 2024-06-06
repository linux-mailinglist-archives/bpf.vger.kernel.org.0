Return-Path: <bpf+bounces-31483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A718FDE2B
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 07:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC0B1F25CC8
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 05:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A9338384;
	Thu,  6 Jun 2024 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPPmNntE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8344C68
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717652219; cv=none; b=CVrbYa/PmnZEO/9BFVQfibIaBm67eMw7gCEMjGkgQjHQgxCWeErOgUuqyZ33U2D7iE+YmFij8P8tvUolk/MkgV1Ffg94XhpFwn2hD9+cWJGom6IsUzu9sGAmHnQ/QYDF9dcdBlpioJOp3z+LSs2D5p9ICdJsr1Rc/qPpMt2dIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717652219; c=relaxed/simple;
	bh=ZElMrsoHp2J/iUIPHZOKnAqjVwXfoRwwboo6IEeM+RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUwEFUoazStWjyTBG0tzXlcdXfhHN2tlVsfCAO3DCTGASeEdLSD0eH8MtqSJvXi+mS3kAFUjHEl+fFP094cw8V3PEzqejaur2DgkpRhrWq7/jmTYLACvSnQphPZHTArX+xrYQWmViF9OgFVgYPgpq30jOFTUSzmD95yDQQUKdHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPPmNntE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35ef3a037a0so217524f8f.0
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2024 22:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717652216; x=1718257016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsgalRlq7qQFolT7eFF6rV07ZLhqbx2B/EvfSGbQTW4=;
        b=GPPmNntEtdIGxfU1g/+XmS0+03rGKCPtI0hErxm6q4WiPJ48VVYUufPtEvwsMjdBFh
         S8IvbJZdRmIqJ7HiAG6zjWo9qBHzEJdvr4ByWqL/0XfoaZQCp0bgo0B9Tljlcf0lzHL5
         XV9wnRR8aOB66T4e9ZkntBUc/gkD+gQevr5zE802P5MnqrsUgrOapMLTLdFdfaxBHk7U
         MpCwcqelhlo1C5zZAsx0L7LHQRQGNsDhl3hehcTE/BkJ6W/N3gzIPeFrqt5t7NOBE8Xn
         AYAsFS2c2AKy8zxIZ84/+05D0cCOVG7uEkUyZPTHH8deNhDgap/Cb23UdiUFfPxR6VDH
         vDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717652216; x=1718257016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsgalRlq7qQFolT7eFF6rV07ZLhqbx2B/EvfSGbQTW4=;
        b=be4TlNfM9qzgqHql1W3Gy7FDvVml7ey+zdaRYQVGu7+yLOBenE1OQ+QCc5+FpLgF/5
         MWQWe0DIiJeR7J0FnvTH3OctXFESfS3P9/9MPKVVgPwMAy9F7aUA6rNv9N/yJIqj6nUf
         Su3iKXz+wgWKbi2dwCmpzrIKKowVVULBWiMsIhY/RD/fMb7CYEId8a4CtiSCBr2ZiQBw
         v3PJjbwYO7hAepOg8KD2NsR+5BmmYsI8ONJfTwguzdveC7qgeHkNqAnxchdcrU1ukfl0
         9pCqHRFrRhfoCFH+Hz7AjpF9VWQPpl3Yy6hlbgOxooab3JZnV8xyvtg0GqkGfvvGLxga
         PWRg==
X-Gm-Message-State: AOJu0Yz2cPsxno9CMwuz9BGRe2SMVsZ0DvvoZI1NYjp++W/ROyHA9yqd
	1A4l/kyVcIYc82mPsrI4nHHjyJolaOVaMLu9hnFTKEu/uhptDYIdZTsG/ZXGKWaxZqH1Eg1r6GZ
	tojpnnIa3WJY17RRlyYRhFGMIPj1DEg==
X-Google-Smtp-Source: AGHT+IGls5GdqwIzv3lEtNYzpAbxSI18zsMCMk8YqjrTcBkgF+PI7TF7aJO0yY1c5CBBt+HB9e28zMM50aiJ+qNyheE=
X-Received: by 2002:a5d:4e50:0:b0:354:f5f2:1997 with SMTP id
 ffacd0b85a97d-35ef0d7209cmr1322473f8f.3.1717652215909; Wed, 05 Jun 2024
 22:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220917153125.2001645-1-houtao@huaweicloud.com>
 <20220917153125.2001645-7-houtao@huaweicloud.com> <CAADnVQ+0eTwL_iJo8Y79GHB-8zAgNCV7Ka9Mza1b+8ENOShBvw@mail.gmail.com>
 <3a21310f-e5ec-c9fb-86a8-6eeecb0b6975@huaweicloud.com> <CAADnVQK0U8pdW0NAno5fS7RYpZcPDWxNHXYaunw4foP9JFLZnQ@mail.gmail.com>
 <8038fc1b-1d73-c8df-9cd1-2dfcde8360fc@huaweicloud.com>
In-Reply-To: <8038fc1b-1d73-c8df-9cd1-2dfcde8360fc@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Jun 2024 22:36:44 -0700
Message-ID: <CAADnVQJV6XQgFjEx1pCVxcnXegB7Zeo5KZgZowCrvCoVef8imA@mail.gmail.com>
Subject: Re: qp-trie? Re: [PATCH bpf-next 06/10] bpf: Add support for qp-trie map
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, 
	KP Singh <kpsingh@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Lorenz Bauer <oss@lmb.io>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 9:32=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> OK. I will postpone the change, but I still think posting a RFC for
> discussion may also benefit the generalization of bpf_ma in slub,  andI
> could do that later.

Yeah. RFC is always fine.

> > Please prioritize qp-trie. It's more urgent.
> > At LPC multiple folks requested a good data structure to store
> > variable length objects.
> > .
>
> OK. Will do qp-trie first. Could you elaborate one possible use case for
> the "variable length objects" thing ?

I hope strings are just a subset of "variable length things" that
qp-trie can hold.


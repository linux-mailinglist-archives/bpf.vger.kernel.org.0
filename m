Return-Path: <bpf+bounces-17092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B627809982
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66BA28223E
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 02:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B75F1C17;
	Fri,  8 Dec 2023 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI70ubfq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5177A1715
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 18:50:21 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-33339d843b9so1740498f8f.0
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 18:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702003820; x=1702608620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZHCwqz4gn2nmwAO4Lns3nglKIgxDkMd9Hi2AdGsPNU=;
        b=XI70ubfqzm0z5ecC/wRzVu05NztG3JTjf6fwvvQTvVebDvG2iLYdhRxt4AY/QigMPe
         GhCbiAotdI76gnku/QpkQxYsQ/MEP+hWZX7hjPJVsZFe1F2sFaasjg0H+LHA4EnnmgKg
         LUAaURlFE0B2ZW4fn2EKbsSJNkkV+iQp638vvU06prUgdXrj/OQidkZs/A7RDwO566D0
         KrCQYko4hSoNuMZyz+8M8WDDO+FFr9jOSOZHoB2krOEwIai1dD3lsY81obPLYkwEtF+A
         bwkYFoksAMFRue7ifPA3U2hjpizfEGs6ImY0hiPt8PS3zFgXhS20wZptBUYGRV10PaWo
         skJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702003820; x=1702608620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZHCwqz4gn2nmwAO4Lns3nglKIgxDkMd9Hi2AdGsPNU=;
        b=uZUL9l/zvuikqWpQRd8F01fG6XyrZDdSWv5wjQe+43nd4N6rzIEhrncpm4bQJ/FUZp
         lKymRdzACqt56gwhBD+Yajx4ESOHbTgzu2y+JwvC20uC1jLFJZZDof+7FdoXEUDxU9Kv
         zJWQEamQA0W+QCTP637byWeId5hZC2iE018J3Oodnp67EF3n9HodSTkkfOsZDfjDUVZZ
         qLZHEa22/xT0SlY0RS69BdImNBNLDuBRaOHWgGotuzlRtzfhdjH5CSfBsy8nEjE9yE1f
         HdnyTEt2YGmLwPOJTHYoA5pc6NamqBfcWDfxklxw9W6GRTxzLC5bORQi3f6r++IcZ/Wu
         TlyA==
X-Gm-Message-State: AOJu0YzsXBVborIK3/6Ge0KemlkgSSVmjBKYlfb+WwgncNMBSIT5dkQz
	iVgWfyaQJHlZLGpSP0O1SvBeA9oGr5T3/qWrF+jkNw5I
X-Google-Smtp-Source: AGHT+IEdwXMbM4XaMMRSrPHuH4nQRwPoqL8tWfj8xTmG1YG0DENko2uwhJH/4Uy8DrmqYr0bp8czB2ZxBlbqzZUthdE=
X-Received: by 2002:a5d:6286:0:b0:333:2bd6:3df9 with SMTP id
 k6-20020a5d6286000000b003332bd63df9mr1810970wru.24.1702003819553; Thu, 07 Dec
 2023 18:50:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208023150.254207-1-andreimatei1@gmail.com> <CABWLsev1q+ves60giYt7rFU--yfhCjgchyoduttgZa8mjynEeQ@mail.gmail.com>
In-Reply-To: <CABWLsev1q+ves60giYt7rFU--yfhCjgchyoduttgZa8mjynEeQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Dec 2023 18:50:08 -0800
Message-ID: <CAADnVQJ7TAwfOpPpk_GeN9OuN1j49+YwLKK=pXWbfAWykJnN8w@mail.gmail.com>
Subject: Re: [PATCH bpf v4 0/3] bpf: fix accesses to uninit stack slots
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Hao Sun <sunhao.th@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eddy Z <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 6:45=E2=80=AFPM Andrei Matei <andreimatei1@gmail.com=
> wrote:
>
> [...]
>
> Some decorum questions from a newbie:
>
> I'm not sure if this should go to bpf or bpf-next (or perhaps if only the=
 2nd
> patch here should go to bpf and the rest to bpf-next). If anyone has opin=
ions,

bpf-next please. The changes are too tricky to expose the world immediately=
.


Return-Path: <bpf+bounces-78928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7369D2010C
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 17:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DAB33009113
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09003A1A3F;
	Wed, 14 Jan 2026 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw9eiKgO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5133A1A37
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406400; cv=none; b=AotfzRCUmQxx46/TkEI5AcDF0u7q0SVeLKueYqQ016RIKymEYRpfM51uiTfDAhcF7Al6q5nEL31bDUO/209CRpPmH6GqVdxUlM57oOgL2GnWihqE/BaO07pVmy8DXCDGHHA8ebuHxH/AYZ/I37EXXa87yMkrcUr887E2QycBWWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406400; c=relaxed/simple;
	bh=JoMapuJzRJ9AYfgrNAHVD6Ey3B6uuhHgOt1Eqqko6GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvfPlZUcvAz9StjLHeKcJR5/NiNr3hVgFCfs0zdiHFwwgxeeobKhNqPMjnWJtvgnbpqEZtF51cc+n4vfWQy2Z/WuHhXisVBi3l1j0UjPy3LHXkbs6ccHoIQNXxMyOwZzWZz7ty+QdBPei9cxrylCDLqDnoKhf0dMIgUOcZbCpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw9eiKgO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbc544b09so7007140f8f.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 07:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768406396; x=1769011196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoMapuJzRJ9AYfgrNAHVD6Ey3B6uuhHgOt1Eqqko6GI=;
        b=Bw9eiKgOyESHh1HPo7xsVtXgNpPqspD5wCAb9HvhvQDcIcKJPVQaZngAvCC3+iLQeM
         YvWZA6NdjYNWz5msWcjH2GSjVE3LOqueha+ESI8oCgy2Bz2Bzy0kWQn9mD+19lEaEA/b
         IWcbsBfXcyiiDwtnK6s6yMlgXoWXz8SNfZ6+561gOB3xBeCeGZvCZbmESY0HYgw0UWBf
         mDDzva8yWP892eykm4HF+XilU+jy4JG/BUmS4QYT9I9K7JimN+dvMtyBFxnexeFXytD1
         ai4EujTpaLoLDbvrfzWOuw1xopHFUFT6OH6xy5lNbk0mMSItjmdwo9rIANdTIapkqjNw
         ba5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406396; x=1769011196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JoMapuJzRJ9AYfgrNAHVD6Ey3B6uuhHgOt1Eqqko6GI=;
        b=qxuMUxvREgisHOxxr9fO+lG4mzo8NS+lSsLlauR0snmHckLqmet0UcYNiDV6UlXXop
         VFN17zkP3GzPtXVkPdzr6/f4JkNEzd6iFGqWlF7GGEO5vB4zpz/gh76kfZnlzHrqcCgX
         90RMr+4MW7rS8KsFGLO81fkY5IqTx6eLbVX8ZhnRWxmcC6WPhPeKEiiET2iH5Nh+Fhnn
         ACeQ+j8MaUjg3fPAaPyrzZS51fyT9cD8y9XOXg8FiqQkx6ssAZvMxuw6vojZP3DXOypP
         9T8dSQBm94MknPFQCVA1IQBo1pyh445mgP3HCxjUNv50WyVdehI0UM3Th+DPJKFsltVI
         +fmA==
X-Forwarded-Encrypted: i=1; AJvYcCVJc529+xtSquofw/tJpBCj2ZorR3YIGc1jjsM2u2NoTPEq0ME+ETnIlGdCeKZ6V5LUgkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoVI126kDevvRo1SYcrh8MUWGP0PUyCHeDWE2iXQ4A9OpULZ09
	r3Vusr+kPbQLqAT58lccfu1EN92RN69ZZysAMUScKjVzeja54+VbrAvt8lrHVLPjAe62K9YGkr1
	lQ6xc0qC1XY5ftEDiKD4xSb2SAAsMEwY=
X-Gm-Gg: AY/fxX4bqUrfJBaQbUrT1M9xkIqWev5V62qvhQ1SymIXeOOXC+p6bffGxUKcHKN2MxK
	szNGjZ3qtWV2+BBLf9VTiBmQx6RSgSMoTQUy4xiBX/EALMLyC98EXK/jjAcR9LYEbWo4MlTyewR
	4VEvPIay6Z0MJafRXYrtKzMTRxsU35Hwuwj1GkPfWxTT9DCqoi+1xyOjvzxMarswRHrWejrJQ6b
	X0uza8XO3RXSIUozklDnUUVyylRi9lXcvpaNXR/24/ACVV+q3uuqzRraN4aTgCphj479tmT0hty
	4+Wjx5va5xQ6qi2iMw0aeLe1Io8u
X-Received: by 2002:a05:6000:2381:b0:430:fcda:452d with SMTP id
 ffacd0b85a97d-4342c4f87abmr3643454f8f.22.1768406395661; Wed, 14 Jan 2026
 07:59:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP01T76JECHPV4Fdvm2bds=Eb36UYhQswd7oAJ+fRzW_1ZtnVw@mail.gmail.com>
 <tencent_46C4281AB1F93E2CA77698CF9DCE0E2FAD08@qq.com>
In-Reply-To: <tencent_46C4281AB1F93E2CA77698CF9DCE0E2FAD08@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Jan 2026 07:59:44 -0800
X-Gm-Features: AZwV_Qil_9UtOFoXZnNsBg9JWtZonN90SAGLDtWNkBNzQ_C2Mul7tyk9D48fzGM
Message-ID: <CAADnVQJqnvr6Rs=0=gaQHWuXF1YE38afM3V6j04Jcetfv1+sEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/verifier: implement slab cache for verifier
 state list
To: wujing <realwujing@qq.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	yuanql9@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 12:30=E2=80=AFAM wujing <realwujing@qq.com> wrote:
>
>
> ### Interpretation of Results
> The comparison results clearly demonstrate the performance advantages of =
the optimization:

This is not your analysis. This is AI generated garbage that you didn't
even bother to filter.

pw-bot: cr


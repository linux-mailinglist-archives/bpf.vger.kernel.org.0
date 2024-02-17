Return-Path: <bpf+bounces-22220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D1A8591AE
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 19:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388C21F21911
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EFA7E0F0;
	Sat, 17 Feb 2024 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frESDHjN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7A7D3F6
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708193995; cv=none; b=a9wOn5a5N1TRBnACUQGe6A/YKDP9H+4lecCYt6lzmmRIDxrkWp2pC509OZ8AKZpmn4PoYmQVvxX0RDOpsRX+S8S2BMiUqPlnZkQG7HCjClcg98wSaJRkjHTa+JTYMQncwv3GQ3DK9jtxtn0j/LUNayVyYZkABsOgh/Tt0/RnmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708193995; c=relaxed/simple;
	bh=Tupk2Egd3bR4FOCdRkjIZ9o0uxwaNlrI3NsKjqMHbiM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZNgBj5+Ktr/4OYhpyXSK0vqs0S3I8TZpu7p8Scp8pbUOSl+83nNxViwQjiRiFAx5v57IYUDc4oF17kCuVbHncSPwxaExolRXjgc/7E+UYqbNNpuFfu9Va2Ce07vb2JDDInhmtAIwcy2cexEuuVaiji3YGXWbL/r7F/ekL7Hfs9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frESDHjN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so2208121a12.1
        for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 10:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708193992; x=1708798792; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tupk2Egd3bR4FOCdRkjIZ9o0uxwaNlrI3NsKjqMHbiM=;
        b=frESDHjNjBnvXTBmIkXR/zLr1Zzk0iDwXRqoycZDI5Kt0LQDY0xYrV/fZ1ftHTRNP2
         hLY7PwdfzEnUxtUZ92Ltcu4BzipkkjEOSc2LwP3excb284wGFI+Oe98nGjiCWAngBH5/
         5R4+J3Bhunc37gcZs6q3VgIHsBF9rZZHKy8pPNgjMNicu2GVkJxDMR8JcqZD+EDUsPLa
         9QXcBms3Rb80+LatXsUJWdjhC0YRa+aGNjkeEP4fxQAdZ38D/BQnjUjIZAaBLUn5nHvz
         9ILj4L9FyX3hEgBvu5opwIFxw2oqr79L5NmAavo6piELTN58ewsJKkqJbb0txqabBiOB
         F0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708193992; x=1708798792;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tupk2Egd3bR4FOCdRkjIZ9o0uxwaNlrI3NsKjqMHbiM=;
        b=ZjY6VgkTxfOUZFfq4BfCYszbPTX2jqFvBW4JQZcFLRylnbub5AJHTv4bHNLRPJ3vfN
         znr/3+h85i5Ln5Wvpu4HFBgv+KI/x6A3LCs3CzcuC9k8n6NMeInogb6IJrR0l0uNOkSE
         DzLrjykIb9FgVSF41fUEtpT+Adc0YwA86s8hbmU1zWEu0wCKuiuJhP0Vnpt1fEVHXNOy
         l+vQgWwo4ZdQANRdighKiN3oAD+kXP2XCXOrlxQxkOU8jPAYVkRZ+FWI1BkkZ0b4sR8G
         5pJhRHNwc+BfkzjvXKMMYPSotx+vIuJXPzqRa+BhLd+E3C/Dymyt/GjCNbMWUYcABRxt
         iTUw==
X-Gm-Message-State: AOJu0Yxkz+pQ0FX2vjF7IjXavj7bhpUvMlHlKhKCSSihFbRuxR9mjBbb
	0ndB6T68RMSYuAyopcuIKNmFUMcEWF8IgExAv9ni5Sh0Bgo7OOnV
X-Google-Smtp-Source: AGHT+IGNhSTG0gfnqjxQi1IyRKimNHhEFNA6ejOL/0srfmccyg+68kq1Swi5nrWehKAhESuC1gpQVw==
X-Received: by 2002:a05:6402:1502:b0:561:8918:9f5f with SMTP id f2-20020a056402150200b0056189189f5fmr5753211edw.24.1708193992199;
        Sat, 17 Feb 2024 10:19:52 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id en16-20020a056402529000b0055fef53460bsm1087122edb.0.2024.02.17.10.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 10:19:51 -0800 (PST)
Message-ID: <a5002108e494d8811bf121ae18ed99d3200119a0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: check
 bpf_func_state->callback_depth when pruning states
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  kuniyu@amazon.com
Date: Sat, 17 Feb 2024 20:19:50 +0200
In-Reply-To: <CAEf4BzaF8tEt9aTOhKfst9_LoMX5OCV-9iUxHrbk76oet552=A@mail.gmail.com>
References: <20240216150334.31937-1-eddyz87@gmail.com>
	 <20240216150334.31937-3-eddyz87@gmail.com>
	 <CAEf4BzaF8tEt9aTOhKfst9_LoMX5OCV-9iUxHrbk76oet552=A@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 10:16 -0800, Andrii Nakryiko wrote:
[...]

> Missing Fixes: tag?

Right, sorry aboutt that

> Also, shouldn't this go into bpf tree instead of bpf-next?

Will re-send v3 with fixes tag to 'bpf'


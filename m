Return-Path: <bpf+bounces-44581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E729C4CFB
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 04:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA2DB25837
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 03:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33FE1990AB;
	Tue, 12 Nov 2024 03:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGEu7gah"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D31E574
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 03:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731380501; cv=none; b=e/dQJDrwLC07/kXIoCvpGkYem08UVRMLZPUmsgdFIrNX088HyAiie3j/L9FbnJYAbDJmnFfER22Hk4Sc0WoLUv9gj338uuaWGokQagKsywZLQ/hE/7q6X5UJVhT/eWfTHW7e8kVVZVad6Hm7sz8gQaEXR9xmWXTBB7x3EYNK5oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731380501; c=relaxed/simple;
	bh=Q4eJLQJIO0tRJmPjwdq3N9VpigxssVhGYke9DzWvzBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwpp8UrcfrSt3R5tWM50aHe6bPt8hFKxuvLynkkhBIADwhO0lt7I5u96Bp6bl8U+M+vMTN73uUspjHjc30FDeFpMG6QxBn3zobQYlWKKOn8OUBKxwpRCp261PGGoQIrC1KJO/BP2r7Ug1aG9Zj0OmLSTG8nX4k/bmci0EB5OoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGEu7gah; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d50fad249so3844586f8f.1
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 19:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731380498; x=1731985298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4eJLQJIO0tRJmPjwdq3N9VpigxssVhGYke9DzWvzBc=;
        b=fGEu7gah76p0kUQiipGoNKfJbI58CWUAdbXNTDyVzEuKtnoP1EWVcNtJMsFzMl3hC9
         agscQDhPYVcevtuaqq71akYID4jBjJLTGbKHQcKr5K6fLxhdgrSq1WUusC/wB53ag5gA
         XaThWolB/Cba/vY6k9TdW9rJkHithxjnR6yYJYwfDBixYu0yCuCBY8K/ABuS2RfPwNjl
         TkqPzdqOSyc7RnE15TPXcMxf4ejQ+XaeUW0dfseDSa7N7DWmCJr4p7/lAqlfd0lu6Edv
         l3Q2sMflAvj8Dz+tUtEDkEkAyW7cZMfjZ1OOiSaMYDEPdzQsN04IzYO6LKSMT8kX/JSG
         aKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731380498; x=1731985298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4eJLQJIO0tRJmPjwdq3N9VpigxssVhGYke9DzWvzBc=;
        b=hJU/MIBENqG1bsywkLLuWXca+2QkhWxSbJktfn3vwfWvBRddYcx3m+rnrKRtmmnoHV
         AoZFYwiBAxzmKXraZ/f9WUJjTrFSxbbbAOmd9cczlHgqNDiRRzNvoTNiqWRlwz922tV4
         sVckDYVwtNuCTVZJfmW1OLaLVdWKElr+eESV3aMCqTUeqCTwxAHSMcfJYkkoWpwW0DV8
         ORZc45SHsxAEiB9vd+Ez4edaIkT3EkF1ikj4gvKR0KS2uXQMjDirYk6WcRXm8Mdzo8ls
         S6HbLlkkK6d4mJPuESOnWsppHdWEfZT84qXy5CuC27IORNXlZc7KEOFOy+fBxz2hcOgh
         hGRA==
X-Forwarded-Encrypted: i=1; AJvYcCUO9xG2aGakcQAjZuM1DlKMnAvBVl/45QcWW0JgHKTWQuK6USD4hF/YGGm8wWJh6wO6RQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7AP6bX7kVeuUbVeDs2zda5mHzEooXd+diTgbMMK1qBxjgk53
	yxc9rimNZra0INICek/XnMtMTbV5wc1gNHelMMhBX8UbxiK8CviL/MCqC8QvwpGRLQs0XLa1h1P
	ILCLKpGiNa3gP2e+G3Qc4nYvXyLw=
X-Google-Smtp-Source: AGHT+IGIoaYFtFDBhVvcjd6aafJfb0uBL51tSM3vuKuW6IznPaIlW2Tl6ktG3SNW7prLKF8rprW71TOpvMw/+JESBNY=
X-Received: by 2002:a5d:5849:0:b0:37d:4318:d8e1 with SMTP id
 ffacd0b85a97d-381f186db1amr10766618f8f.23.1731380497814; Mon, 11 Nov 2024
 19:01:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110112905.64616-1-dev@der-flo.net> <a917cefe-28d5-ceeb-5cfa-4fbb8f9a3c9d@huaweicloud.com>
In-Reply-To: <a917cefe-28d5-ceeb-5cfa-4fbb8f9a3c9d@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Nov 2024 19:01:26 -0800
Message-ID: <CAADnVQKKaNkmyCX5EwL+k0YZXFFrT4v+QtwDX6_7d7oJXjp=UQ@mail.gmail.com>
Subject: Re: [bpf-next 0/2] bpf: Add flag for batch operation
To: Hou Tao <houtao@huaweicloud.com>
Cc: Florian Lehner <dev@der-flo.net>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Anton Protopopov <aspsk@isovalent.com>, Kees Cook <kees@kernel.org>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Martin Kelly <martin.kelly@crowdstrike.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, yikai.lin@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 6:15=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
>
>
> On 11/10/2024 7:29 PM, Florian Lehner wrote:
> > Introduce a new flag for batch operations that allows the deletion proc=
ess
> > to continue even if certain keys are missing. This simplifies map flush=
ing
> > by eliminating the requirement to maintain a separate list of keys and
> > makes sure maps can be flushed with a single batch delete operation.
>
> Is it expensive to close and recreate a new map instead ? If it is
> expensive, does it make more sense to add a new command to delete all
> elements in the map ? Because reusing the deletion logic will make each
> deletion involve an unnecessary lookup operation.

+1 to above questions.

In addition:

What is the use case ?
Are you trying to erase all elements from the map ?

If so you bpf_for_each_map_elem() and delete elems while iterating.

This extra flag looks too specific.

pw-bot: cr


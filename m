Return-Path: <bpf+bounces-15275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C16717EFAFC
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 22:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9D11F257CC
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED6B36B1C;
	Fri, 17 Nov 2023 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pqq3JD+e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E623D5C
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:40:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so515758f8f.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700257253; x=1700862053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6dgh8gWMh5TRkqtqiSdQIWIW1w9xgcu56WSasT3sVA=;
        b=Pqq3JD+eb4l3tupumpRmp61QTLpl66x4JUD8z3yzK0088mFXxJizQp2YlDMh1jMBfC
         6WPGOHhQP5jtWK7/3TnY4R7zbR/doE7yPqAm379BLUUrxmc3gfWY/DM9SLKpOValnaj+
         6hhwD1/l8yFPgky7uHuRRNIJhWTCOMZ3Xu5zORyemPTkBR4jWEFSJzzrULU/Yzxof9/3
         Vzcu74V6GTdJPVrSqM+1lnsVoPxd1zrpGvr+BNjtUY/3TuDB6swzCg95uD0Qk+jkRuGC
         A98nfiSC1KF11sYZVWOQ0uSfLdh1343owlWxc9qxMUG35EsrBBS40SJfF73QfyFfkh5k
         84XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700257253; x=1700862053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6dgh8gWMh5TRkqtqiSdQIWIW1w9xgcu56WSasT3sVA=;
        b=H4NfV89Gf/a74HSDIdC54MPSeWSePbBFtmS0c4CrEwLB0RQECVLPxm4swG/N+QGbh1
         R+kduqE6wTiYcRDnrIJhJgQveYXNHUGYYBUOaE7+YCjer+ulgqYS1bmJ48+nqqGENsyw
         nWupB+VHN3/V5/WuwGU0h/cxJfPXnebsDeUchEtXVI/HzxSg25SE8TaJgLq1Rd1MhbTH
         zLp3UQqDRWNZs7g+Xhh7lcLYOKmMn0IVpROzsWgs1qY9zDZaZcTG9UtBJ/AExXESLZGi
         JR7aryqFbgHpl/q+HZqTqI/kbdVcjGgtPThmJ14Oi6InKCoKzj4wfDz/V6sznKiWE6eQ
         u9Lg==
X-Gm-Message-State: AOJu0YxQ8s6aOtMavPSrttHPAkK8pjKvGVjRU2GCgf7sw3wmCQKPEcJj
	tClVlaDsYJ/BONOLqWfyNrTLbnbnQvxDf0r6p1M=
X-Google-Smtp-Source: AGHT+IFy9oRwn8FsuynuIG5yJcIRdItLfS4cYNrg5bFlXai0GHN2pUeVe471FjOXjorTHCrNyFoncRWa0vm9ogPd3fQ=
X-Received: by 2002:a05:6000:2c5:b0:32f:87e8:707d with SMTP id
 o5-20020a05600002c500b0032f87e8707dmr5468250wry.5.1700257252719; Fri, 17 Nov
 2023 13:40:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011152725.95895-1-hffilwlqm@gmail.com> <5ee643a8-d39e-470b-83e9-9d550374e617@gmail.com>
In-Reply-To: <5ee643a8-d39e-470b-83e9-9d550374e617@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Nov 2023 13:40:41 -0800
Message-ID: <CAADnVQLV5T9+_Dbd=yg4a5-4hQPznAVxdZ42ps50EL3BmnRdcQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 0/4] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 12:33=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> w=
rote:
>
> PING

Sorry for the delay. I didn't have a chance to think it through.
I hope experts in the community can take a look soon.


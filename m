Return-Path: <bpf+bounces-57255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D429AA78DD
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 19:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E3317118F
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 17:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B232609D0;
	Fri,  2 May 2025 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnehpX0f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910224A32;
	Fri,  2 May 2025 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746208443; cv=none; b=loM8+jnf9XLO0AbX2YUACyTM9eCsGCLbbeQRMUpXNlG4xZJAf5JO76zrvWTN+nrcXbsj2AdSXohjHBS1dtXWp347mB9cLnONWuRGvPSerieQVwTezLQtyjjUXF1GI63VWmV1SvswLCRcahgupfpRgccm9HalksmvdYzQQAnfp5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746208443; c=relaxed/simple;
	bh=ZfbEwFziy/+4B2qUyM5vjQWrVAUxklnDjbXAavZR/+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyfdhKpdT/IKsm8PDIQ6PsnhMlYtKIHkSbQVZiC7WB3sFGDDgzE6W+8D6BxZDssfIgCXrNhqOHbXnIYo5Lx2lS7OaVnPg7P/uDEXrbMIn33BT8WjcLnworUyBw92g+0b43jVuffFjfPwaz+ujIVFAKdJF9f/qL48GBTFWwkNIBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnehpX0f; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e740a09eae0so2072496276.1;
        Fri, 02 May 2025 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746208439; x=1746813239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfbEwFziy/+4B2qUyM5vjQWrVAUxklnDjbXAavZR/+0=;
        b=LnehpX0fvb7jba3NseDvlnYVQhjwLR3q9OB8dZWQ3vDZCbuzN+Z/BkE/WHVwqtm4Qe
         ie3xy0tHwRUkCyC1u/TuwUNO3M+hSoE7IqfdkO4azxi6jSVX9HsjVNEKQakPoZIhWn19
         MtbwIytOQ1CpDp25/DH53LLog2l6okDId1zLiPk6bT0zZB0GS6bMdDqlFesqu8+3A7B4
         x7eCOsCHxjcwLE++GUfwVMxpiE0HqqSHo6TY0R279AYMsHFJm5BW8++QE0K8OEueQ66n
         FtK3xFI+jLj1GU4nL7RYjsDagkmfdrD9rH6kVGe3fnB4hUkZPJ5FySP3JTuwvZVnxByq
         woaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746208439; x=1746813239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfbEwFziy/+4B2qUyM5vjQWrVAUxklnDjbXAavZR/+0=;
        b=kmfhPgzuWKFlfm2rG9RuN/AbfBDoOv63SlwxO1JzHi3hqgbWZGIlEoESSNlS97U9VV
         zscimAFeU+bdYdy4AwjvsZptu2DK/eJxVzCWgQbj2ht3fDPwALMV7FpdvKLEgOiAgXOD
         EqfPmKPQT9rMG7EebBcXSGYGzmm4HTvBm9QfQq+posycTuXLxMQfRfwYFSiHpMrG3URo
         G6szyR7ht6OL0nIBCjq2v/fxPx0YCDh4QK1pBgoin3u40h5gMUXcVBYM+qg34aLV9cK0
         B8X4HEQ27jMjnAaqDJF5kPqzaFkTvi52ioFD1D6GH62s5YscDShE039UGWyoTycLYIo6
         HpOA==
X-Forwarded-Encrypted: i=1; AJvYcCWMyLjtk/NsLoMjksJiAlyHCFH1gd90xVBd/CyuyaG8wWtcLdvuXfVSJwANZ4iLs3vodkXV4VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKZdC5euTt5OJM4mpibO2RatuvCiNRbpas27fXamO8E0R8DakO
	fWd/VNKBz1pMcQUxN+GYzvLiSNRAYNqXlcXN7nOSI8QdYUkzznvdNMcB6RDIRxfmU+/Qf8nEU+A
	bBHutV+t9LrnvD3ZADfMV+yUB+jhfwsuD
X-Gm-Gg: ASbGncvXG/VsfNsOb7zrYxa8sGOT5ZgGGs13dmbrUFO1GNDHmFajCE9zexNHnG+13T+
	isBYQ5cmxqzH/1/PbijjMKNpqWFFTB0TSCl/6aBYvE+EPdjPejFrpKkzh40noksviUNijtrwgKf
	wnFzx/UG+yhNvv7nZ1tp2img==
X-Google-Smtp-Source: AGHT+IEY+GywdK9E2dZhEsZnsPpdiKyWAL0RVMGDBChgNcQBIKUIrJN+0+jPjqysO9/Mghc0WjBOjlqWDgkmedXJ6yM=
X-Received: by 2002:a05:6902:2781:b0:e73:2284:4ec3 with SMTP id
 3f1490d57ef6-e7571b52927mr262929276.42.1746208439344; Fri, 02 May 2025
 10:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501223025.569020-1-ameryhung@gmail.com> <20250501223025.569020-6-ameryhung@gmail.com>
 <b395276d-81d4-4a6b-aaf2-297c78a6c33e@linux.dev>
In-Reply-To: <b395276d-81d4-4a6b-aaf2-297c78a6c33e@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 2 May 2025 10:53:48 -0700
X-Gm-Features: ATxdqUEPV6LS417ZqIzVHabCdgMm_idaUVjknQ_bXsiAUUT0VHMja95ow30T9lo
Message-ID: <CAMB2axP5Sbk-oU5nxaK5NjrjMO+WRU_tc3DkG1BsSC-wKL6UHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next/net v1 5/5] selftests/bpf: Cleanup bpf qdisc selftests
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	xiyou.wangcong@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 5:22=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 5/1/25 3:30 PM, Amery Hung wrote:
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/too=
ls/testing/selftests/bpf/progs/bpf_qdisc_common.h
> > index 65a2c561c0bb..c495da1c43db 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> > +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
>
> There is a recent change landed in this file.
>
> Overall the set makes sense. Thanks.

Thanks for the feedback. I will rebase and resend.

Thanks,
Amery


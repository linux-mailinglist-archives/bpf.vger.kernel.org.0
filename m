Return-Path: <bpf+bounces-49815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B329DA1C4A6
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 18:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0881889228
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C13470803;
	Sat, 25 Jan 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfTOiR9X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216D25A62A
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737826432; cv=none; b=IveETr0V8L+ZadK3vsp1vASIztyN0HGADCO32REu3WRmdPOW2VBLgzrKAZ1UA6GCFZfgs6AYX2NQFXdf2FH73m6DlW0ZdmiZij0tPazqJO3G+obKdeDhAgamBgNciEuVOW4CjwvAh1xUdYzUQQm8JGCffFtckeHaO4VBOTQlAug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737826432; c=relaxed/simple;
	bh=+6irHsuKzAX62pZXQHLQOE5xG2HmZgU3t45tnAxVzD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkLHyBbiLCjqZxgPKNnR5makDozsp/uSqJXtMfUiiCTaC6WY31DBxp8+1nO20mUS+T7rdKMm6uvtfCYQVYtloQKd2PfihhXRDvUsrlEIf9qCxXcPZXBTCZwuUyC/MdfEK+0YoUTBb0nFDgpYcWAPUYStCZLcUZ2rOd/V3kyqKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfTOiR9X; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1732754f8f.3
        for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 09:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737826429; x=1738431229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6irHsuKzAX62pZXQHLQOE5xG2HmZgU3t45tnAxVzD0=;
        b=NfTOiR9XRUwLWjfSDScUXNZi4oS3BB477Pdbcu/wrT2tSkoNxoYbGnAUUW/f+B37bh
         wudQqomroVjLynJ/bhkkXB3R6YbQD8O4vTbVvPxcZLILW0ekL7gatoGdfL5aGgwmAZZb
         LkAKSj1DPRsbomjg9Jr/O5Lud/1Z+C4ZzPfk6q+L7wML2JJMyOMSJTyVrmbYjXuNlWOr
         j2oMVFP7cfjoEZWYoJ/UwSBVOgsaJg21tlF40Of6Dbv1NTv8BIFo+g00ljwSAiGumzrZ
         etUfveXfRSvQgD/a4SIhjah0t/TH4HLdsKXSB8MGKmxXhvHLtlPqgDy7qEx92bSr0WEd
         XA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737826429; x=1738431229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6irHsuKzAX62pZXQHLQOE5xG2HmZgU3t45tnAxVzD0=;
        b=a56yB+Toh1UawT/l4J9iGWYxJNQVreLSus+g2Vtd6vWjzqVFEYH0Ltan44GVyNygFB
         wsqjm8WI8yq3ngT0qXRbu4EpCaPHl6AOvYqIO0x7CnGeeliuXzsm5M1TbMSjNYn0+pDT
         wi1fBP5020NmY3yoexjhsy5JdEAJlId+z1oX386NBLJFP9OUfD8qRV8hn8rNxE4LL0wT
         g4ATt587yjOfB9ywSGyPKTU8xBoYxNyWRZX9sFUd7mzvcFKB4ZIUWA0Idm3uCtlYiyV3
         O3ZmCIohMq3k7Z1ibuvuf1FM1+fH9txC2niwKIHEyLkDm4bJkGMINkNyIFjg/w8QqQko
         mlKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUedQVlEUoFdRzdKGax4da9jvaF4X84QiaQljuZXy5/4JRve7uk84hHsEItKxX+O0y8oTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YziSxJp5AigftE4MizYglKPuj6sw6/d3uJ5S7UizrywLV2rKJjB
	jlGG5uuMReiq8NybvhfWdZOIcP5e0AHhfK3KoPg/u4KN43DSVO5qKVVB2jFQtB7CzofJb4xa89v
	+sSi6Ipsg5Ky5hkurW/dCyOoMQ+I=
X-Gm-Gg: ASbGncv5purMMymupGy1iYi8baNDPFiQrcBb3HnLHLQF29OGYiZk9YWmodbfmqt14cA
	ujGeLs08T8RttP7VyQnmgdXDo0E7SYQF0z9K9pSiUyQUwe43Oy84mheNFHgOY4WOZ32vdEzZFFj
	s+ycLSXDK/4QWDHPjjFg==
X-Google-Smtp-Source: AGHT+IFqmdVbITLHUKYNG3v4QYsfPBBhD57Kp1FNAUKdXN7NLchTjNJ7uE24aufTk+2SoLprc9HRhn7b38KpDG4zyDs=
X-Received: by 2002:a5d:588f:0:b0:385:f220:f798 with SMTP id
 ffacd0b85a97d-38bf5655b12mr30201168f8f.6.1737826429234; Sat, 25 Jan 2025
 09:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM_iQpXiQQ8Pv03ubsfq0=2h0XQ7xLAVDvhWFZjt-7M2OqxhhA@mail.gmail.com>
In-Reply-To: <CAM_iQpXiQQ8Pv03ubsfq0=2h0XQ7xLAVDvhWFZjt-7M2OqxhhA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 25 Jan 2025 09:33:38 -0800
X-Gm-Features: AWEUYZkaPoF-qdNyeKkXEon6BogrdaxC8OYoT8eZCkQyQk4x585yXcvy8_MkC0c
Message-ID: <CAADnVQ+wPK1KKZhCgb-Nnf0Xfjk8M1UpX5fnXC=cBzdEYbv_kg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Two-Phase eBPF Program Signing
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 7:06=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> The naive approach to signing eBPF programs faces a critical
> limitation: programs undergo mandatory modifications by libbpf before
> kernel loading, which invalidates conventional signatures. We present
> Two-Phase Signing, a solution that implements sequential verification
> aligned with the eBPF program lifecycle.
>
> Our approach establishes a baseline signature during initial
> compilation, followed by a secondary signature that encompasses both
> the modified program and initial signature. This creates a verifiable
> chain of trust while accommodating essential libbpf modifications such
> as relocations and map file descriptor updates. This approach enables
> precise failure diagnosis by distinguishing between compromised
> original programs and unauthorized post-compilation modifications.
>
> The Two-Phase Signing method balances security with practicality,
> allowing necessary binary modifications while maintaining integrity
> verification throughout the program's lifecycle. This approach
> provides granular audit capabilities and clear identification of
> potential security breaches in the signing chain.
>
> We invite discussion on the implications, trade-offs, and potential
> improvements of this approach for securing eBPF programs in production
> environments, particularly focusing on practical impact and
> integration challenges with existing eBPF frameworks.

This is certainly an important topic, but there is already a solution:
light skeleton.

Pls join the discussion:
https://lore.kernel.org/bpf/bqxgv2tqk3hp3q3lcdqsw27btmlwqfkhyg6kohsw7lwdgbe=
ol7@nkbxnrhpn7qr/

No need to delay it to lsfmm.

If you believe that your double-sign algorithm is superior,
please explain it in that email thread.


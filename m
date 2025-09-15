Return-Path: <bpf+bounces-68392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F558B57D41
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 15:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED18E3A2C68
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC59A315D2D;
	Mon, 15 Sep 2025 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGd85hzs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E130A31328C
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943128; cv=none; b=ru02JC3oBaNAe42mgBdw8ZcURoOmoyCa7DlnZ9kV3KU6RIwaEQwaq6/uKCT6gFBUj4x7qkeuR+h43zIcXCpRobGTBQwPACLIw9wzf47UFD6iTmWQ8W9pi5GVqqeKimow9MZUY26nl2idhonQZbjTWhuF8XBsW24XIfLBLR1NQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943128; c=relaxed/simple;
	bh=JuAfAE/DQ6C0D2lXfJ9FEF35Ereo/GyutU1m8Vt32xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBNnXPqMgXVTm/fOpumCkTl2tzGXzlnw4xih81NdsILe0XnVf+cAG7hEi/S+yU8Iuy0zBCNeFAqI8Nj1chBAny55E18F6xoTuVlOW3Z0+4fxx/Aj8OEH6yOFl3wxASS6HG/yxPIPsBlOsgzx9Sn7MNqu5VHuqww3rTpVl6AZxZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGd85hzs; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3fe48646d40so28604405ab.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 06:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943126; x=1758547926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuAfAE/DQ6C0D2lXfJ9FEF35Ereo/GyutU1m8Vt32xM=;
        b=LGd85hzsfk1nNzH7s5/7tXTpCxt2WY2llck9gqA8uriwATDcJoevE2S1g7DJNZkV0c
         wIxxHySlgksLch7wSGFUoNlqEsKOrasxoAKg42NHoOOMEC7lN1sVfWo2c859AG6wVB6y
         0G8txQuWYZKmNnOtcVKr40MzqKdfGKi9BmjWpjDID0cTwl/mGYObCZh/5Q9EPRrKoCrD
         sawUwWPruqZHUaxqEz+y5XQzFe6mdg6WsSiPkN48ofpYwslpGct+ZD4+bRMz61fy8+iH
         wJ07WZcPsOc1T/eCnB2wNl5827rN0IlUVlj6WGUUssuuQAn8FtjxenlsNvStJW+OzC8a
         Lsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943126; x=1758547926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuAfAE/DQ6C0D2lXfJ9FEF35Ereo/GyutU1m8Vt32xM=;
        b=HL2wwAk2831/Bhdv1n4zCmBltik0dWQK2xX8pwhAgyrG9/Tgybn06XqGP557CW0w69
         mkkZ8qCrFyuXRW4zbvaCXKAz3d9ZewKKZBnF1mnqK7Y6GZLvaXfGxLAt+KepabRFIzZv
         zy/u4NKFVz2T6v9RyQTRxmQEbxGlduS80yMLe7AWxCkJjRqid/Pr9GafqIqXQBtU9CjA
         DcbznbLWCFgW90Icho+oV9u/720iiFSvHc1E5KI4KinqMvKUIaVJ4XNbMrlJVRfzV0bb
         Urwf4rsLM795YtzgUZv8fyLDsMsrdn100OrCW2FKbk23oXScBYahI0O5iEXRzWUA5ytE
         7hog==
X-Forwarded-Encrypted: i=1; AJvYcCWXvhbymrUlAugom+ehWY8JWS9g0U5kIn5aPI718yzgekaUJvx8D1NrW5I5sZCCNovADpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQP1iltaj+bpq6FtObFH8scw+J/kTzJ6EZ+jnG0y+Y0YQpwagY
	Ac0oF35oryS93gX/wTt7NC72fnZP1VnDJYxhZKPnYVDjlqvwi3MrqlLxTlpBcNB+pJ5QI1kFfVz
	uNjrISTZK0c+ScXhg0zAsxN8OnWgTsQs=
X-Gm-Gg: ASbGnct0Cc73ePwDRZJ8/lbjsWg9PjLssX7mPeOR2cJJ0FDmbbW+KYQMayfG9r2rz7S
	xppqXnAgnA9V21h4t4nmKHrXHupZ8hHk9pXPm+c2s4wnfitzvn9nTATFlAlD/oDkl9tkLt2UcWk
	shdCmXuyXqCvvpPilm4j7hUoP8pnNRyB2rFWjDIuYkWZSnf9pvbFVJ4mHVxr0o8BYZ5XAqhH18j
	Vvzgg==
X-Google-Smtp-Source: AGHT+IGam6DvCP5qsiaCB14TjREG+7uYzPOTczFKePk1aQFZiI0UEOoWy07XYRuywR01Hd1k0m30wxyZJyBQaaHvyQQ=
X-Received: by 2002:a05:6e02:2168:b0:423:fe62:568a with SMTP id
 e9e14a558f8ab-423fe62571amr51750835ab.10.1757943125603; Mon, 15 Sep 2025
 06:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915120148.2922-1-magnus.karlsson@gmail.com>
In-Reply-To: <20250915120148.2922-1-magnus.karlsson@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 15 Sep 2025 21:31:29 +0800
X-Gm-Features: AS18NWBhZh0TBZjUCC6NY3tqZ2Dcwk953fVOyw0JO2qzZ422l706jJbh5z-mOfI
Message-ID: <CAL+tcoCcTuD_usfbpQWn5Y=rT=Kw2iu7kze2YqqP9V0AzjXWRw@mail.gmail.com>
Subject: Re: [PATCH bpf] MAINTAINERS: delete inactive maintainers from AF_XDP
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 8:04=E2=80=AFPM Magnus Karlsson
<magnus.karlsson@gmail.com> wrote:
>
> From: Magnus Karlsson <magnus.karlsson@intel.com>
>
> Delete Bj=C3=B6rn T=C3=B6pel and Jonathan Lemon as maintainer and reviewe=
r,
> respectively, as they have not been contributing towards AF_XDP for
> several years. I have spoken to Bj=C3=B6rn and he is ok with his removal.
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Oops, well,...

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>


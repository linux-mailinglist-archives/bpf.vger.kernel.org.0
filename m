Return-Path: <bpf+bounces-37289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B657953A91
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4721C21AE5
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 19:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482078C9D;
	Thu, 15 Aug 2024 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPu7K9JL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4D12CA5;
	Thu, 15 Aug 2024 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748861; cv=none; b=OA7/bne4HZ9aZFH7jfyN3BxAQ5akxGxLbD9M+sR8FjvsprfWivuEvk0YUVl1QVUURNeAf7eYOs67xr3Flop/yaoVpAFbvKo6seQbQi79kfQbIoQ7rSkaoobAzcxekp3rv4JG89Z2e6O+c0dCrSjYT6gYjuv7LLBEcrnfd711rI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748861; c=relaxed/simple;
	bh=Yc7jnolC6CalfMQx2EFCDRpHzxfWieMgqorOb9kmQWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOE5wvs7crlM7/C6ecwf2YSZ1NSFu1JcQJ5ZdO62Xt9gTNvuyxVGDZoPNUqxesgW8K3knPj2tpgJs632Viy5bca6exEiJkJ6JCPcpHP3qXT14PUHxzR1Kwas5XZWrJGgacnXpP+6+GrF568CCuCZNRv3wgyI2HGkmQbBWKTMmf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPu7K9JL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so106654666b.1;
        Thu, 15 Aug 2024 12:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723748858; x=1724353658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yc7jnolC6CalfMQx2EFCDRpHzxfWieMgqorOb9kmQWQ=;
        b=KPu7K9JLs74vNpO/c6+e66ZgHYVa9BiRV7zMWF5nF3eeA8nwS2JSKtZ3PKeBe1I2md
         67v3Qub046NPQNyMhLkxxzOatTiQwxCBkpsOSjmT8waDluXhMdGzBbGEx1yBUy/+hIvA
         uFOroPvzS9+rFRNiY4Ym+1u7lyCiSyw5qGXLtj4gt29S1btefL/GCanL4Pno55ICwbF8
         RRWvW7qTDP5FopjsUPj6xAtFfWZF5fVCiitHuWk32Q05ulAZqo2VDzhg96YtHVRp+eaD
         rLjuuI/84DiShLuhO36ika0EZHUUZte3LlgUO3lYh0cDjT7au85+2xTQ+qlWOBS+0DJB
         1mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723748858; x=1724353658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yc7jnolC6CalfMQx2EFCDRpHzxfWieMgqorOb9kmQWQ=;
        b=GR0v1ZevP0os/gHy1V7JTYdQtjIImmnmtOCep61Uvpqq0I4RVKyyfzkUkM5BLb6vJn
         0tNrPJYX4iA9e+5OGtEs3Qyw3Wv0LmvH1ELkTepwfas5JY4XEA7fwkCaL+MKxAkJ8iqz
         +R+1cUBOGortWf/rbVOz2zsuuptvDjD8J+GUOCqrL0w9ujCv8zApHUJ5zKZJFxSA00kV
         +mcE+DCOUHVx7xaGiaqy2O+rdwTcSVweBUp1aruS2xsxIYUI0RTWomNueScb4yggJYHj
         cH6p3GzSrmJiXp1I5mpxPYXqDQBVLL1LXBX7C6BNRMwMW2Be6gUJuC3ujDr4Dlriw98G
         E/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWyLJLXIqN81W4dH8TJDgDQCmIFk/iDXP0kB6CINaJ6lazPPYz3h19VoOVCLVU9P1vkWoX5Vy9VLJly+M7MmKaxrpxBfxmHBpMqHwo8gz3cVaN3Tjly0eUp0i6L7F5OpZCXPY+OsPHnm2Jok9OKpYCfubUrNXmMo8wm1QwLDuP6iOHacFho
X-Gm-Message-State: AOJu0YxxllzTT6c7Paf9B5aJGCVCHSN4zUErL6XIb55BTh5tpD+WD5P4
	2hokM01j43ks3bz8YAAUfaKfYEJjMCQ7QIYWK2dhfnmso3Wiv+DhPNST5rqKvi3Dwkp9NxLIWqa
	qEMghNP2O6o1lbZkk7ck0cDd+Yfs=
X-Google-Smtp-Source: AGHT+IH4SMSBfHTMulRiORRB1NruG1pcreXQqKgKEcXW428mFt0Q5m23XCgcf7kpgicWS8rViGurds0qeUkHj9zorB4=
X-Received: by 2002:a17:907:e266:b0:a7d:c46b:2241 with SMTP id
 a640c23a62f3a-a8392950874mr40645166b.29.1723748858241; Thu, 15 Aug 2024
 12:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240813042917.506057-14-andrii@kernel.org>
 <7byqni7pmnufzjj73eqee2hvpk47tzgwot32gez3lb2u5lucs2@5m7dvjrvtmv2>
 <CAJuCfpG8hCNjqmttb91yq5kPaSGaYLL1ozkHKqUjD7X3n_60+w@mail.gmail.com>
 <o46u6b2w4b2ijrh3yzj7rc4c3outqmmtzbgbnzhscfuqsu4i4u@uhv65maza2d5>
 <CAEf4BzZ6jSFr_75cWQdxZOHzR-MyJS1xUY-TkG0=2A8Z1gP42g@mail.gmail.com>
 <CAJuCfpGZT+ci0eDfTuLvo-3=jtEfMLYswnDJ0CQHfittou0GZQ@mail.gmail.com> <CAG48ez2VwmFU7ubongD1AnYJDf2-RrFod33Zvbjy1NwRj4-Y1A@mail.gmail.com>
In-Reply-To: <CAG48ez2VwmFU7ubongD1AnYJDf2-RrFod33Zvbjy1NwRj4-Y1A@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 15 Aug 2024 21:07:26 +0200
Message-ID: <CAGudoHETsUtwR=KJpMCEfbZazxv-FbYgMSe_Lk4MV0CVg0h9ow@mail.gmail.com>
Subject: Re: [PATCH RFC v3 13/13] uprobes: add speculative lockless VMA to
 inode resolution
To: Jann Horn <jannh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 8:58=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> Stupid question: Is this uprobe stuff actually such a hot codepath
> that it makes sense to optimize it to be faster than the page fault
> path?
>

That's what I implicitly asked, hoping a down_read on vma would do it,
but Andrii claims multiple parallel lookups on the same vma are a
problem.

Even so, I suspect something *simple* is doable here which avoids any
writes to vmas and does not need the mm-wide sequence counter. It may
be requirements are lax enough that merely observing some state is the
same before and after uprobe lookup will be sufficient, or maybe some
other hackery is viable without messing with fences in
vma_start_write.
--=20
Mateusz Guzik <mjguzik gmail.com>


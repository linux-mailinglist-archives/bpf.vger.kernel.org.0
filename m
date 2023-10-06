Return-Path: <bpf+bounces-11540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425767BBBB6
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 17:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6581C20A9A
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6803327ECE;
	Fri,  6 Oct 2023 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="P3xCQSAh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E6B273D3
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 15:25:42 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABADAD
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 08:25:40 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59f7f46b326so26363397b3.0
        for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696605940; x=1697210740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRTUcfgGw1TIS6SmsAy+1faR7U4cBS26ibPRkKhW4JE=;
        b=P3xCQSAhf0lUfMgSy+FKv457Bu1DqNUC+MwewI4hizDcX9GA3xF9a24WS5nZg+I9IH
         xbjcyAlk/IXGfp1HId5J4CeW2KX5w3xTij0fg0E2EU1tFAXIutWAqtXyRU9qVEF0eHF1
         h9fnU/p2HWhxNTALd0pAm/E0YsHQWFoBrArz9VupNxUhMwpKLL8yy2DYiGnBG24KvN24
         oSo4shhR/EFZy4g6w0WuKXps03qSqRZBLjqvwxR9hTNVfJsN12C836F0lMg5FLNNyXwC
         1LGOrYEDhkBAj6nH6AQlZnvq6y/9HeZ5CCgVrOwpYnV8YqkmPR6seT9Owhyj6XQPyN2O
         ahrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696605940; x=1697210740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRTUcfgGw1TIS6SmsAy+1faR7U4cBS26ibPRkKhW4JE=;
        b=RvJXbdA1iNEuVe0UAqOjNIHsc/uHtz+JBNhybB/V791TK8u+X27mpLIWRz32cAYLdj
         96wb3St1CEOfulljvCnoxhwJuRjWW/7qfWHxkr9tMcpZ4LLrv0PvS11ipIDOFZDo3rkg
         5dHLCDjUeG+QebEIM3vy7tExBQwYYdQPjrhT84EL7nrwOjiEvo/s/9VVRuObByeAsl1g
         aLLTzjS2hl5EAfnp6/6eMfYIxnJZjYsmJ184eMLz/uypDk5/Celm4LHOAp6Fvah4QkMs
         q6Tbku2LXTg+tOtTfxw4eJrjFnvHAs93xEwoRJjxBAU9Nygl4EpdYLhtECVlOJhn+uch
         maCw==
X-Gm-Message-State: AOJu0Yw/aUWl8sSuovJm9cnwNP2JKG2C+SGdOpGn/sQ1S+yIBDWx6Sq5
	o4gtOXSGUdQx3eYw1XopBmmCsDiL/9xdq5kueMUFsA==
X-Google-Smtp-Source: AGHT+IH9EVCDP7PiOtTVf7il09efVo6VC0Sx6niTMJ0jLgTc6aPqEzblZr+QCFwPv7++EcKWkxhrpghiPXI1NmK6aXI=
X-Received: by 2002:a25:374b:0:b0:d7b:9624:94c8 with SMTP id
 e72-20020a25374b000000b00d7b962494c8mr8055560yba.3.1696605939964; Fri, 06 Oct
 2023 08:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919145951.352548-1-victor@mojatatu.com> <beb5e6f3-e2a1-637d-e06d-247b36474e95@iogearbox.net>
 <CAM0EoMncgehpwCOxaUUKhOP7V0DyJtbDP9Q5aUkMG2h5dmfQJA@mail.gmail.com>
 <97f318a1-072d-80c2-7de7-6d0d71ca0b10@iogearbox.net> <CAM0EoMnPVxYA=7jn6AU7D3cJJbY5eeMLOxCrj4UJcFr=pCZ+Aw@mail.gmail.com>
 <1df2e804-5d58-026c-5daa-413a3605c129@iogearbox.net> <CAM0EoM=SH8i_-veiyUtT6Wd4V7DxNm-tF9sP2BURqN5B2yRRVQ@mail.gmail.com>
 <cb4db95b-89ff-02ef-f36f-7a8b0edc5863@iogearbox.net> <CAM0EoMkYCaxHT22-b8N6u7A=2SUydNp9vDcio29rPrHibTVH5Q@mail.gmail.com>
 <96532f62-6927-326c-8470-daa1c4ab9699@iogearbox.net> <CAM0EoMkUFcw7k0vX3oH8SHDoXW=DD-h2MkUE-3_MssXvP_uJbA@mail.gmail.com>
 <2ce3a5a1-375d-43a6-052d-d44d7b4a4bf8@iogearbox.net> <20231006063233.74345d36@kernel.org>
 <686dd999-bee4-ecf8-8dc4-c85a098c4a92@iogearbox.net> <20231006071215.4a28b348@kernel.org>
In-Reply-To: <20231006071215.4a28b348@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 6 Oct 2023 11:25:28 -0400
Message-ID: <CAM0EoM=SHrPg2j3pmp-CG7v1g_7KaENEjgdwQ7HWOhN3NxUnng@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from return code
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	paulb@nvidia.com, netdev@vger.kernel.org, kernel@mojatatu.com, 
	martin.lau@linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 10:12=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 6 Oct 2023 15:49:18 +0200 Daniel Borkmann wrote:
> > > Which will no longer work with the "pack multiple values into
> > > the reason" scheme of subsys-specific values :(
> >
> > Too bad, do you happen to know why it won't work?
>
> I'm just guessing but the reason is enum skb_drop_reason
> and the values of subsystem specific reasons won't be part
> of that enum.

IIUC, this would gives us the readability and never require any
changes to bpftrace, whereas the major:minor encoding would require
further logic in bpftrace.

> > Given they went into the
> > length of extending this for subsystems, they presumably would also lik=
e to
> > benefit from above. :/
> >
> > > What I'm saying is that there is a trade-off here between providing
> > > as much info as possible vs basic user getting intelligible data..
> >
> > Makes sense. I think we can drop that aspect for the subsys specific er=
ror
> > codes. Fwiw, TCP has 22 drop codes in the core section alone, so this s=
hould
> > be fine if you think it's better. The rest of the patch shown should st=
ill
> > apply the same way. I can tweak it to use the core section for codes, a=
nd
> > then it can be successively extended if that looks good to you - unless=
 you
> > are saying from above, that just one error code is better and then goin=
g via
> > detailed stats for specific errors is preferred.
>
> No, no, multiple reasons are perfectly fine. The non-technical
> advantage of mac80211 error codes being separate is that there
> are no git conflicts when we add new ones. TC codes can just
> be added to the main enum like TCP =F0=9F=A4=B7=EF=B8=8F

We still need to differentiate policy vs error - I suppose we could go
with Daniel's idea of introducing TC_ACT_ABORT/ERROR and ensure all
the callees set the drop_reason.

cheers,
jamal


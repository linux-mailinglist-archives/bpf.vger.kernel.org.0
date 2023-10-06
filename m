Return-Path: <bpf+bounces-11565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A567BBFC5
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 21:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BA0282445
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 19:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94EE38FBC;
	Fri,  6 Oct 2023 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="vYvUu2ff"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EB93FB2A
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 19:40:07 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4477C95
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 12:40:06 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d8162698f0dso2842238276.0
        for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696621205; x=1697226005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4bbOBXZo2eHz6gBYk8A+BKEjjzNprtQoptukpt2aww=;
        b=vYvUu2ffb81XUTZrba104b8jdS2CT8B3rH9P+EEDbzo6tny3iCT4cXgY/myRKKWwQg
         fuvTxk2gHVC5iKGz2sd3yTmCpalfIcf69H7YTzs5hWZf7vaKVb5B0zZP1AaNf/O1klhU
         GBEwKz8zPt5yA/+NIEu6/JoMRklH9Ll6xLCKjTZC+Xlgquq2tbmJ1HmssT9jbh4Bj5I9
         2u106bYCWK6lHyWEU1HYik5m/aRq2ASb1AoZOWDq3uwwAJZLXcrVBb/evV5eav7+ttm6
         crujZHuuQyY/VKVI4POvVETlMnVxhhHAFGrfA6bnEcko/9tGj8J3AcxAili0t0f2ezHP
         Fpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696621205; x=1697226005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4bbOBXZo2eHz6gBYk8A+BKEjjzNprtQoptukpt2aww=;
        b=RjiZ9oWm9E3/xxIYHV0d+rh7anNG03gMIHOSgVw9aMTjAhOmp6p8u9MDWjQXtCaXL6
         RkLcXSjLXOOkmqhYyRaa5jzIceViB7rw8DcDc2y5XAk2apmrKDAXih4yxI72Bn4/+ulA
         coTSnuJfRY/opnHmHkKkzEIXQcoe/HJxh6CY2nnkKC9ptJYF16KKNqtaRRebDgfN05ET
         ou8mHKr1KunXsx+bUAc1dLtyaHWnUkcg7U1HoeAvQiPLoZV2q80XY1YEtR6rY0awT90Y
         8i1/1G1/0XnuQJKay//h1cuR5SDnz8/DDKjTm8CBoGPMHfTXocox1pVwbIMRtabdi4JL
         CHaA==
X-Gm-Message-State: AOJu0YyAWahf/XAT8BaDzVCwbCV0iWn40AkgHjxfDMPr8XOxWxv001KR
	RDZRXuDIgoVyYG4fAbXiAxi8m47x+YMGW/fbJ/L4PQ==
X-Google-Smtp-Source: AGHT+IEaFNY2/iItPv+snUJRUdtR/Pc89rA5KoayTxI1pN3MtDCHWZtc1Xb1MVMo6mm4ht1ESAmPTj8JQObG7zSRqbk=
X-Received: by 2002:a25:ce51:0:b0:d91:c3c4:2904 with SMTP id
 x78-20020a25ce51000000b00d91c3c42904mr6920314ybe.17.1696621205377; Fri, 06
 Oct 2023 12:40:05 -0700 (PDT)
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
 <CAM0EoM=SHrPg2j3pmp-CG7v1g_7KaENEjgdwQ7HWOhN3NxUnng@mail.gmail.com> <647b0742-8806-cb66-d880-3d25fd9c3480@iogearbox.net>
In-Reply-To: <647b0742-8806-cb66-d880-3d25fd9c3480@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 6 Oct 2023 15:39:53 -0400
Message-ID: <CAM0EoMkUv8P5ATy9qsJi_N12oGF-BEq_rrHPt=XB_4+5FC3YNw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from return code
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, 
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

On Fri, Oct 6, 2023 at 11:45=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 10/6/23 5:25 PM, Jamal Hadi Salim wrote:
> > On Fri, Oct 6, 2023 at 10:12=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >> On Fri, 6 Oct 2023 15:49:18 +0200 Daniel Borkmann wrote:
> >>>> Which will no longer work with the "pack multiple values into
> >>>> the reason" scheme of subsys-specific values :(
> >>>
> >>> Too bad, do you happen to know why it won't work?
> >>
> >> I'm just guessing but the reason is enum skb_drop_reason
> >> and the values of subsystem specific reasons won't be part
> >> of that enum.
> >
> > IIUC, this would gives us the readability and never require any
> > changes to bpftrace, whereas the major:minor encoding would require
> > further logic in bpftrace.
>
> Makes sense, agree.
>
> >>> Given they went into the
> >>> length of extending this for subsystems, they presumably would also l=
ike to
> >>> benefit from above. :/
> >>>
> >>>> What I'm saying is that there is a trade-off here between providing
> >>>> as much info as possible vs basic user getting intelligible data..
> >>>
> >>> Makes sense. I think we can drop that aspect for the subsys specific =
error
> >>> codes. Fwiw, TCP has 22 drop codes in the core section alone, so this=
 should
> >>> be fine if you think it's better. The rest of the patch shown should =
still
> >>> apply the same way. I can tweak it to use the core section for codes,=
 and
> >>> then it can be successively extended if that looks good to you - unle=
ss you
> >>> are saying from above, that just one error code is better and then go=
ing via
> >>> detailed stats for specific errors is preferred.
> >>
> >> No, no, multiple reasons are perfectly fine. The non-technical
> >> advantage of mac80211 error codes being separate is that there
> >> are no git conflicts when we add new ones. TC codes can just
> >> be added to the main enum like TCP =F0=9F=A4=B7=EF=B8=8F
> >
> > We still need to differentiate policy vs error - I suppose we could go
> > with Daniel's idea of introducing TC_ACT_ABORT/ERROR and ensure all
> > the callees set the drop_reason.
>
> I've simplified the set (attached). The disambiguation could eventually b=
e on
> SKB_DROP_REASON_TC_{INGRESS,EGRESS} =3D=3D intentional drop vs SKB_DROP_R=
EASON_TC_ERROR_*
> which indicates an internal error code once these are covered on all loca=
tions.
> There could probably also be just a SKB_DROP_REASON_TC_ERROR which could =
act as
> a catch-all for the time being to initially mark all error locations with=
 something
> generic. I think this should be flexible where you wouldn't need extra TC=
_ACT_ABORT.

I think this should work - either Victor or myself will work on a followup.

cheers,
jamal

> Thanks,
> Daniel


Return-Path: <bpf+bounces-15371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 465A97F174F
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 16:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACEDDB218B4
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9202F1D55B;
	Mon, 20 Nov 2023 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="XzOmjMW+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE5DB4
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 07:30:23 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7b3d33663so50270247b3.3
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 07:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700494222; x=1701099022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JASRnr1MIQ1rI3DfOcT6HlzVP5tWS5+csjwBSo3Wdtk=;
        b=XzOmjMW+5ioVE22yrnLRRo3YIMDAD3U72iyrHhgTPf3EY5OUyfa3s3/VX4o2rlG61X
         mi0R4W/hGTQYLOO8Y54CjLEj7rnppDW/68XmrnxQSmIGU85hLU0AiarNS9T1I/AaNcRy
         0VEITHo7Dk7+SZEjIdLv6rY5i1k3a0tvSE3MRaxjRXdBX4U6S7FUt3cvhKPoQQsYmFEs
         HkvwHo7z0HtshpJSOoyEXqKJHlAAjkHKhxbxc+X/213ZujoOLNikonno+Yk7TSYpzKEH
         YeaiD3L5I2epHDlVes3v8oKrXzwNEURg7bMY6qgX4p0EXn9ujF8x4fMiq0ql9t01yEPI
         edMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494222; x=1701099022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JASRnr1MIQ1rI3DfOcT6HlzVP5tWS5+csjwBSo3Wdtk=;
        b=IiNCMKrtY7QIOj9hlrBMfDeL19dS/AKKkKBsS3du0P6HvlY4VP9ZJHNsQopEW/2xKM
         GqyHyT40uu871jwqDjIU25xhrMlsuKnsZV5D6b5DV8cUaDntcZXjJCA2hsEOyuhZRp8O
         yJwf6poCzuycJHo+7zDRbw11rX/0G/8lBG+pdOCUCEdv41kOgudLcXVCjZx530tcaOjH
         8GAbGEuFeLqZu2gQrmJYBTVs4wXpfVeaQEyohE/rzcAOL9Z0dTVf7rceamlghupJB6hl
         bJwkjnRVPzK8rLhd7iQi2xaT5NSHlbru9gYpbwuYZ9/k5A+07350UCWuCcPapSyrzHQk
         csIg==
X-Gm-Message-State: AOJu0YxUXFWFZEPQOeRdUNoouFUG3piUHr/6dXrJaxf6C0BsWeckJc/m
	QArREub45D8poMRJMNwGMcRCFl2Xw1ooHmTk7aw6hA==
X-Google-Smtp-Source: AGHT+IHNZeBo7o6Ma45ri2i5HB6gCwcvUW8HyMidt+EjxTSwE88AXLSUgXVczkifB71KlmwFQ4A4QPUiHdFmlYsepPI=
X-Received: by 2002:a81:bb47:0:b0:5a7:bbd1:ec1d with SMTP id
 a7-20020a81bb47000000b005a7bbd1ec1dmr7619169ywl.17.1700494222740; Mon, 20 Nov
 2023 07:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116145948.203001-1-jhs@mojatatu.com> <20231116145948.203001-10-jhs@mojatatu.com>
 <ZVY/GBIC4ckerGSc@nanopsycho> <CAM0EoMkdOnvzK3J1caSeKzVj+h-XrkLPfsfwRCS_udHem-C29g@mail.gmail.com>
 <ZVsWP29UyIzg4Jwq@nanopsycho> <CAM0EoM=nANF_-HaMKmk0j6JXqGeuEUZVU3fxZp4VoB9GzZwjUQ@mail.gmail.com>
 <ZVtcEwICZHsTtija@nanopsycho>
In-Reply-To: <ZVtcEwICZHsTtija@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 20 Nov 2023 10:30:11 -0500
Message-ID: <CAM0EoM=EFJTqeEsJHQZw-3x6TnEMFYT1+Rsm7f4aSKh0QLqBnA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 09/15] p4tc: add template pipeline create,
 get, update, delete
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com, 
	David Ahern <dsahern@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 8:16=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Mon, Nov 20, 2023 at 01:48:14PM CET, jhs@mojatatu.com wrote:
> >On Mon, Nov 20, 2023 at 3:18=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Fri, Nov 17, 2023 at 01:09:45PM CET, jhs@mojatatu.com wrote:
> >> >On Thu, Nov 16, 2023 at 11:11=E2=80=AFAM Jiri Pirko <jiri@resnulli.us=
> wrote:
> >> >>
> >> >> Thu, Nov 16, 2023 at 03:59:42PM CET, jhs@mojatatu.com wrote:
> >> >>
> >> >> [...]
> >> >>
> >> >>
> >> >> >diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
> >> >> >index ba32dba66..4d33f44c1 100644
> >> >> >--- a/include/uapi/linux/p4tc.h
> >> >> >+++ b/include/uapi/linux/p4tc.h
> >> >> >@@ -2,8 +2,71 @@
> >> >> > #ifndef __LINUX_P4TC_H
> >> >> > #define __LINUX_P4TC_H
> >> >> >
> >> >> >+#include <linux/types.h>
> >> >> >+#include <linux/pkt_sched.h>
> >> >> >+
> >> >> >+/* pipeline header */
> >> >> >+struct p4tcmsg {
> >> >> >+      __u32 pipeid;
> >> >> >+      __u32 obj;
> >> >> >+};
> >> >>
> >> >> I don't follow. Is there any sane reason to use header instead of n=
ormal
> >> >> netlink attribute? Moveover, you extend the existing RT netlink wit=
h
> >> >> a huge amout of p4 things. Isn't this the good time to finally intr=
oduce
> >> >> generic netlink TC family with proper yaml spec with all the benefi=
ts it
> >> >> brings and implement p4 tc uapi there? Please?
> >> >>
> >> >
> >> >Several reasons:
> >> >a) We are similar to current tc messaging with the subheader being
> >> >there for multiplexing.
> >>
> >> Yeah, you don't need to carry 20year old burden in newly introduced
> >> interface. That's my point.
> >
> >Having a demux sub header is 20 year old burden? I didnt follow.
>
> You don't need the header, that's my point.
>

Let me see if i understand you:
We have multiple object types per pipeline - this info is _omni
present and it is never going to change_.
Your view is, have a hierarchy of attributes and put this subheader in
probably one attribute at the root.
You parse the root, you find the obj and pipeid and then you use that
to parse the rest of the per-object specific
attributes?

I dont know if a hierarchical attribute layout gives you any advantage
over the subheader approach - unless we figure a way to annotate
attributes as "optional" vs "must be present". I agree that getting
the validation for free is a bonus ..


> >
> >>
> >> >b) Where does this leave iproute2? +Cc David and Stephen. Do other
> >> >generic netlink conversions get contributed back to iproute2?
> >>
> >> There is no conversion afaik, only extensions. And they has to be,
> >> otherwise the user would not be able to use the newly introduced
> >> features.
> >
> >The big question is does the collective who use iproute2 still get to
> >use the same tooling or now they have to go and learn some new
> >tooling. I understand the value of the new approach but is it a
> >revolution or an evolution? We opted to put thing in iproute2 instead
> >for example because that is widely available (and used).
>
> I don't see why iproute2 user facing interface would be any different
> depending on if you user RTnetlink or genetlink as backend channel...
>

iproute2 supports plenty of genetlink already.
We need to find a way to have the best of both worlds.

>
> >
> >>
> >> >c) note: Our API is CRUD-ish instead of RPC(per generic netlink)
> >> >based. i.e you have:
> >> > COMMAND <PATH/TO/OBJECT> [optional data]  so we can support arbitrar=
y
> >> >P4 programs from the control plane.
> >>
> >> I'm pretty sure you can achieve the same over genetlink.
> >>
> >
> >I think you are right.
> >
> >>
> >> >d) we have spent many hours optimizing the control to the kernel so i
> >> >am not sure what it would buy us to switch to generic netlink..
> >>
> >> All the benefits of ynl yaml tooling, at least.
> >>
> >
> >Did you pay close attention to what we have? The user space code is
> >written once into iproute2 and subsequent to that there is no
> >recompilation  of any iproute2 code. The compiler generates a json
> >file specific to a P4 program which is then introspected by the
> >iproute2 code.
>
> Right, but in real life, netlink is used directly by many apps. I don't
> see why this is any different.
>

Not sure if you were referring to what i said about the json file or
something else. The main value is not just kernel independence but
also iproute2 independence i.e not need to compile any code.

> Plus, the very best part of yaml from user perpective I see is,
> you just need the kernel-git yaml file and you can submit all commands.
> No userspace implementation needed.

Two different tacts: i can see this as being developer friendly (and
we are more trying to be operator friendly).
I need to take a closer look. Sounds like it should be polyglot
friendly as well. If i am not mistaken you still have to compile code
as a result of generation from the yaml?

cheers,
jamal

>
> >
> >
> >cheers,
> >jamal
> >
> >>
> >> >
> >> >cheers,
> >> >jamal
> >> >
> >> >>
> >> >> >+
> >> >> >+#define P4TC_MAXPIPELINE_COUNT 32
> >> >> >+#define P4TC_MAXTABLES_COUNT 32
> >> >> >+#define P4TC_MINTABLES_COUNT 0
> >> >> >+#define P4TC_MSGBATCH_SIZE 16
> >> >> >+
> >> >> > #define P4TC_MAX_KEYSZ 512
> >> >> >
> >> >> >+#define TEMPLATENAMSZ 32
> >> >> >+#define PIPELINENAMSIZ TEMPLATENAMSZ
> >> >>
> >> >> ugh. A prefix please?
> >> >>
> >> >> pw-bot: cr
> >> >>
> >> >> [...]


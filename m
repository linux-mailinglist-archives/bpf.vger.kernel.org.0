Return-Path: <bpf+bounces-6308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46FD767C31
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 06:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192772825DD
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 04:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA4117F4;
	Sat, 29 Jul 2023 04:52:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A502AA50
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 04:52:39 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCC919AF
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 21:52:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b74209fb60so42098821fa.0
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 21:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690606356; x=1691211156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmP40yBhEjViAD9Nyb9F4Iw9OdpyGMw/B/5lyQSpVtA=;
        b=pimWZ3Vfe3H/8GIN4S8GIXtD5aPYJJ1sMiyBK3ZxGpaI0BglmABQjX9XaqniYpyuGp
         vSyIvPkq1nino8JFKCrovsirjElRMDqqX5U5kqpU8RB0EcvuH3rMs0p7EcIcwabwaqjX
         RJrPhlKOG9sLATPOUmtQMLjhxKKbvwD8yKMkywE20jmUp5iTmudPmLXT984j+FA2QAGs
         vZNMPE1KQ/bywJjBzfeaRYtqzShjqkVjEIKWvdEYzcGg1xwgZH31enjHTS9kAjoUigoG
         O2am8S0Ye9jvyhDvTOWoNKuEQK43ZDchKhBN5rXXtZ6fM/oGxP9aSTkSt3xkbAbofUSl
         2z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690606356; x=1691211156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmP40yBhEjViAD9Nyb9F4Iw9OdpyGMw/B/5lyQSpVtA=;
        b=NTLqFNI2WSiX1rnT4Rkl4LRIMplkdzngzbJJghZxH7ZpJokRtDwBBU5aqn/cRNVfdf
         adF4m+++Eun3Q+09G6hF6Q+Is1DPWxr1NifFildk83HkXzsfAGjvAJBVBfy+sk5VPP8n
         8yi0kwF+tVwiosi24XhqemqUWI9MIjQuFq0DLiPcvJn2WcI2mtG2xV+NtwUq8fCXcRQM
         Ry7fFW6m5BpFfD45zJ2aTf+aQKpjSCRD5XxmdFJ/MZ+12a6vyXJALFcBhHqrMjXfk/yc
         AucqsM+OcnwvA6/7y8UQghN2lRBpTuvH4bR8/yNAmLSRkRzbgy8sw8mbe4nF5rDGmHz4
         ABSw==
X-Gm-Message-State: ABy/qLZtkWgpnZS1nySoH6Nj0CSvPSViLJehymENq8lNHssAHMZt9ctx
	YsvZbyEqCqVqectquXEUE0fuK4gujo/sr6X6bh0=
X-Google-Smtp-Source: APBJJlFo2XV8VesHg7CLmp7rygmplWsG07ISIewdYwxHH1Hwh4d1GQ7BUr8E8S4dzcJdmq/B1O7szdkOfP2GwH20GnI=
X-Received: by 2002:a2e:9044:0:b0:2b9:af56:f4b8 with SMTP id
 n4-20020a2e9044000000b002b9af56f4b8mr3235700ljg.10.1690606355558; Fri, 28 Jul
 2023 21:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com>
 <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com>
 <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com>
 <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com>
 <CADx9qWh6ZUKvjkZow6=eB4gvEgP82mBqn+mMZvmDQynCYAfMWw@mail.gmail.com>
 <CAADnVQKOiwm1UB58=8QcowDyfPQct-wuMD19citS7w5PmadZ6g@mail.gmail.com>
 <CADx9qWjYChRf2qBr=Pt5D-RLCb665YFKmjDYX8WOQfqMx1-bag@mail.gmail.com>
 <CAADnVQJDO9MgU2MQQ5NQAE3EwL6PuPp8aAxcV3apf0DHoq8TAw@mail.gmail.com>
 <CADx9qWjOP4-2K3uKBTRmS4Q5V0gTJtoH65fwN-MhZvn6ukFpBg@mail.gmail.com>
 <CAADnVQKbpoeMWdnXzYbBaHoDiNsLDbC0JvDUnVGEQbCigjd1Xg@mail.gmail.com> <CADx9qWj4xuYoyz83FphVWU0ZVxy_7Y+SvTWjvChvkMdV290giA@mail.gmail.com>
In-Reply-To: <CADx9qWj4xuYoyz83FphVWU0ZVxy_7Y+SvTWjvChvkMdV290giA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Jul 2023 21:52:24 -0700
Message-ID: <CAADnVQLWKnGbG6XTVEKSto0kEiqHwFaDTp+UkCYipKpov_btRA@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Will Hawkins <hawkinsw@obs.cr>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 8:14=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrot=
e:
>
> The Appendix (the opcode table) is not in the kernel repo now and
> still has the issues that I outlined above. Will that make it in to
> the kernel?
>
> https://github.com/ietf-wg-bpf/ebpf-docs/blob/main/rst/instruction-set-op=
codes.rst

I thought it's auto generated, so it should be easy to update.
If not, let's certainly bring it in.

I suspect it will be the seed for IANA.

Dave, thoughts?


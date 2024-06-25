Return-Path: <bpf+bounces-33009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB55915D5D
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 05:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02198283635
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 03:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D2873465;
	Tue, 25 Jun 2024 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="GaPZpmAF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="GaPZpmAF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOYEu4xP"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A126ACD
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719286587; cv=none; b=TlBRf1Th6NGw4h0KTxiWALwzVghORmoU0NwabXDASjJf9kN0V6n0z0F7V1r5lVxE2dkkaBqkbGvTZsAqJhgJIJqxwKA9LRBl741LjJ+bsyXa+cfN0DZ9NlSW8jcm/EEAb18PVDQgICFwZk4ultxlA8p07K8JfcsrANs5UKTVXBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719286587; c=relaxed/simple;
	bh=yM0/qCoX71b8y73exbFjUQE6mUA/16GIYQ5p8OdPJpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:CC:
	 Subject:Content-Type; b=h300L82IhsgQnATI9ILRTRib693Hg4kHfrhToLP4xT2Si+zcv0AMuF00ydrI+YJnQiMEs2VTVyWhoaLyl96KCCQCCBpAdrc2Kq3A5egB6pXClUHb3IfDNbMOznuG8Z9W+FqG9qpkCtrGu+ABpcL8IAWTuQLDKdbQ5WhXtZZQ0t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=GaPZpmAF; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=GaPZpmAF; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOYEu4xP reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 361DFC14F736
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 20:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1719286585; bh=yM0/qCoX71b8y73exbFjUQE6mUA/16GIYQ5p8OdPJpA=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=GaPZpmAFoIwu5JEd9LBhHhyG+cDb174+SK7gzl2nZlkWhcrAEkq89wRAxtBqWoHmH
	 khr5BKZM2ELFQPDja/rzqh+1/Kd6ngSoqs9YB8DHKEcEQP6vUtkuG1QERmt0iE7JkA
	 ezBoJ7YP+IJzSFrD9v2fX+usuLLJOcRmOqMyDSvQ=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Mon Jun 24 20:36:25 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 1FF13C14F701
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 20:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1719286585; bh=yM0/qCoX71b8y73exbFjUQE6mUA/16GIYQ5p8OdPJpA=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=GaPZpmAFoIwu5JEd9LBhHhyG+cDb174+SK7gzl2nZlkWhcrAEkq89wRAxtBqWoHmH
	 khr5BKZM2ELFQPDja/rzqh+1/Kd6ngSoqs9YB8DHKEcEQP6vUtkuG1QERmt0iE7JkA
	 ezBoJ7YP+IJzSFrD9v2fX+usuLLJOcRmOqMyDSvQ=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id D4F34C14F700
	for <bpf@ietfa.amsl.com>; Mon, 24 Jun 2024 20:36:22 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.005
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
	header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0j_3FQK_TFpd for <bpf@ietfa.amsl.com>;
	Mon, 24 Jun 2024 20:36:18 -0700 (PDT)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id D0580C14F6EE
	for <bpf@ietf.org>; Mon, 24 Jun 2024 20:36:18 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70679845d69so1460502b3a.1
        for <bpf@ietf.org>; Mon, 24 Jun 2024 20:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719286578; x=1719891378; darn=ietf.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xmxHyf4g0NUY0p72j/bVn6ZnkKG5ZTSZzCG2yDGuQHE=;
        b=IOYEu4xPGd6MEARo/Ns8ZEhJ0XPmhauKBQbbwlmWYvdciqOdUIjuafZT2FpuYoj16e
         E5COi/lX8aKkrraCyVvxi7tgVPpMVJJ8Ee/Eaag46wWFg10SyoSdgXVDSmwbkY8DbErn
         6mNG0jer3uapxF8pD2s3fh1cL7mxSi9jFQng6JvJA6M3bvfn8N3q5ktiRE+6FLYdUhCC
         m7Vo6QqJaG7eiVojhatR++iRqo3bUT0eJppduYqNlgQ0Sy+ZjZnCunu4O8H4x4cXJ0EU
         vZ/zzNAFy0XRgpiqG/cwevoJkTYWCRfmr0zC0N/1wXVRXMxYyPa/YBb3xe4LCjQasjsl
         q+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719286578; x=1719891378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmxHyf4g0NUY0p72j/bVn6ZnkKG5ZTSZzCG2yDGuQHE=;
        b=JLGGOE+vr5XB1uW05dBVlMY4BE2L9ku722yiT/vCgYEUcXeoV0Y2EmTSC9ze9qBdYK
         As3zq4Ctk3seHO8/lKJTcfg6qKpMp6QihNNDo1S1RvvV/3xrfo7V2/Fvg7H8PxSxS/aM
         ETC5USdFGfuTPJ/R664MSligqlbi/t61aHgIFWRhlbLVeRG5f3mkwd7bRqz3+N2r+nqd
         zinTnwcmchtkCVwZzxgmCNSYsd3XpXZynm0VQPN3n8/wzYdgM0cPRMkyIgTxp4ZXiQjh
         bTz81zSYER9XoMWk5Owhhni4o06571vCrIZBpOU3atsxuYyIadHtFdMbw9OGVwzmxsWn
         XNag==
X-Forwarded-Encrypted: i=1;
 AJvYcCW68Q649uprN8jewL2EXm+74DVtC7Wki7gg1GPSy+WdavYt1BHM37Sx2QCR39O8493ioI3zS/roO6J1pZo=
X-Gm-Message-State: AOJu0YynB0ppB6shl57DjqRLm1ZzfUcQwR+r+4NQPVjN9PUYu0kp/b8M
	9JDfxcwFeChw7HWeWHZmeUvsYJJ81LqzvITemlVDjBtUl6zDLDWoAqpFTDxu4XzwDtyCjncQUfT
	ad4WBc225hYQq3Eq7LETnbVZTIlWS6w==
X-Google-Smtp-Source: 
 AGHT+IF9fpfufZ0INNaKIL5I5WLrSNQrE9PygInsP7nzqKR3WeSoc0MQM31qi3fuUiXujrEGmdzkHWSyOsj/CYZd1eQ=
X-Received: by 2002:a05:6a20:9741:b0:1bd:10e4:9e85 with SMTP id
 adf61e73a8af0-1bd10e49fd2mr2774559637.27.1719286578040; Mon, 24 Jun 2024
 20:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: 
 <PH0PR21MB19101A296E6A180AD99EDD3898F12@PH0PR21MB1910.namprd21.prod.outlook.com>
 <PH0PR21MB191058745A71A705F199B19A98F12@PH0PR21MB1910.namprd21.prod.outlook.com>
 <CAEf4BzZf=7Sb9Zf7Bt_oJh=Pq6b=03wspmr8iJSY-KRyJVZ3nw@mail.gmail.com>
 <0c4801dab126$7a502fc0$6ef08f40$@gmail.com>
 <PH0PR21MB191000EA2B7A038CE99C5B5398FA2@PH0PR21MB1910.namprd21.prod.outlook.com>
 <PH0PR21MB19108A5EF85F75C9F273D14798C92@PH0PR21MB1910.namprd21.prod.outlook.com>
In-Reply-To: 
 <PH0PR21MB19108A5EF85F75C9F273D14798C92@PH0PR21MB1910.namprd21.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Jun 2024 20:36:05 -0700
Message-ID: 
 <CAEf4BzaJbjVY-qnjS0=8U_TEwpQTigvbGnBpou+mA6P8DOiuzA@mail.gmail.com>
To: Shankar Seal <Shankar.Seal@microsoft.com>
Message-ID-Hash: BUOOMY5QTGA3HFI34RLOR763UPO3HNMR
X-Message-ID-Hash: BUOOMY5QTGA3HFI34RLOR763UPO3HNMR
X-MailFrom: andrii.nakryiko@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: Shankar Seal <Shankar.Seal=40microsoft.com@dmarc.ietf.org>,
 "dthaler1968=40googlemail.com@dmarc.ietf.org"
 <dthaler1968=40googlemail.com@dmarc.ietf.org>, "bpf@ietf.org" <bpf@ietf.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BEXTERNAL=5D_RE=3A_Re=3A_Writing_into_a_ring_buf?=
 =?utf-8?q?fer_map_from_user_space?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/cw0X25ZQ3etIOvo_nVEvjS78vQs>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: multipart/mixed; boundary="===============3573771859435456013=="

--===============3573771859435456013==
Content-Type: multipart/alternative; boundary="000000000000c05ae7061bae99bb"

--000000000000c05ae7061bae99bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 11:49=E2=80=AFPM Shankar Seal <Shankar.Seal@microso=
ft.com>
wrote:

> Since I have not heard back on this topic, I am assuming that there are n=
o
> strong oppositions to this idea.
>
> So I am sharing the signature of the proposed user API.
>
>      /**
>     * @brief Write data into the ring buffer map from user space.
>     *
>     * @param ring_buffer_map_fd ring buffer map file descriptor.
>     * @param data Pointer to data to be written.
>     * @param data_length Length of data to be written.
>   * @retval 0 The operation was successful.
>   * @retval <0 An error occured, and errno was set.
>     */
>    int
>    ring_buffer_user__write(
>        fd_t ring_buffer_map_fd, const void* data, size_t data_length);
>
> Please let me know if you have any questions about this API.
>

I think the devil will be in the details. API itself makes sense (you can't
simplify it further or make it much different), in the end, you are just
sending an array of bytes into ringbuf.

But the implementation details are what matters. How the notification
works. How user space won't break kernel even if intentionally trying, etc.
It's not clear where you intend to implement this, etc.



> Thanks,
> Shankar
> =E0=A6=B6=E0=A6=82=E0=A6=95=E0=A6=B0 =E0=A6=B6=E0=A7=80=E0=A6=B2
>
>
>
> ------------------------------
> *From:* Shankar Seal <Shankar.Seal=3D40microsoft.com@dmarc.ietf.org>
> *Sent:* Wednesday, June 5, 2024 10:01 PM
> *To:* dthaler1968=3D40googlemail.com@dmarc.ietf.org <dthaler1968=3D
> 40googlemail.com@dmarc.ietf.org>; 'Andrii Nakryiko' <
> andrii.nakryiko@gmail.com>
> *Cc:* bpf@ietf.org <bpf@ietf.org>; bpf@vger.kernel.org <
> bpf@vger.kernel.org>
> *Subject:* [Bpf] Re: [EXTERNAL] RE: Re: Writing into a ring buffer map
> from user space
>
> You don't often get email from shankar.seal=3D40microsoft.com@dmarc.ietf.=
org.
> Learn why this is important
> <https://aka.ms/LearnAboutSenderIdentification>
> Thanks Dave and Andrii.
>
> Per bpf: Add user-space-publisher ring buffer map type [LWN.net]
> <https://lwn.net/Articles/907056/>, the API that you mentioned
> "provides single-user-space-producer / single-kernel-consumer semantics
> over a ring buffer."
>
> But this is not the desired behavior for our case. We want both bpf
> programs in kernel mode and user application to be able to write to the
> same ring buffer, which can be consumed by a (potentially different) user
> application.
>
> Assuming no such API exists, do you see any strong reason *against* writi=
ng
> such an API? If not, we would like to implement one in microsoft/ebpf-for=
-windows:
> eBPF implementation that runs on top of Windows (github.com)
> <https://github.com/microsoft/ebpf-for-windows> and eventually provide a
> Linux implementation as well.
>
> Thanks,
> Shankar
> =E0=A6=B6=E0=A6=82=E0=A6=95=E0=A6=B0 =E0=A6=B6=E0=A7=80=E0=A6=B2
>
>
> ------------------------------
> *From:* dthaler1968=3D40googlemail.com@dmarc.ietf.org <dthaler1968=3D
> 40googlemail.com@dmarc.ietf.org>
> *Sent:* Tuesday, May 28, 2024 10:42 AM
> *To:* 'Andrii Nakryiko' <andrii.nakryiko@gmail.com>; Shankar Seal <
> Shankar.Seal@microsoft.com>
> *Cc:* bpf@ietf.org <bpf@ietf.org>; bpf@vger.kernel.org <
> bpf@vger.kernel.org>
> *Subject:* [EXTERNAL] RE: [Bpf] Re: Writing into a ring buffer map from
> user space
>
> [You don't often get email from dthaler1968=3D
> 40googlemail.com@dmarc.ietf.org. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Tue, May 28, 2024 at 9:32=E2=80=AFAM Shankar Seal
> > <Shankar.Seal=3D40microsoft.com@dmarc.ietf.org> wrote:
> > >
> > > Adding bpf@vger.kernel.org
> > >
> > > A common use case of an BPF ring buffer map to use as a queue of
> > > events generated by BPF programs that can be read in-order by user
> > > space applications. I have a scenario requirement for a user space
> > > application to write into a ring buffer (or similar) map, such that
> > > events by BPF programs in kernel and user space applications are
> > > interleaved in the order they were generated, that can be consumed by
> > > another user space application
> > >
> > > I would like to implement this new feature in the
> >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.com%2Fmicrosoft%2Febpf-for-windows&data=3D05%7C02%7CShankar.Seal%40micros=
oft.com%7C0d269a2ce1364e2be3fd08dc7f3da157%7C72f988bf86f141af91ab2d7cd011db=
47%7C1%7C0%7C638525149885854034%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA=
iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DVEDCtA=
H%2FtGTBOUmRFzf%2BlPbhyVejY3PoJex5yOmmQQE%3D&reserved=3D0
> <https://github.com/microsoft/ebpf-for-windows> project. But before I go
> ahead with
> > the implementation, I wanted to check if there is any way to accomplish
> this in
> > Linux today? If not, is there any reason why this should not be done?
> >
> > Yes, there is. See user_ring_buffer ([0], [1]).
> >
> >   [0]
> >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.com%2Ftorvalds%2Flinux%2Fblob%2Fmaster%2Ftools%2Ftesting%2Fselftests%2Fbp=
f%2Fprog_tests%2F&data=3D05%7C02%7CShankar.Seal%40microsoft.com%7C0d269a2ce=
1364e2be3fd08dc7f3da157%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638525=
149885863954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC=
JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DTu9BXn%2BHuZvMLRRqC6Kvg%2=
F6V1vVrJ2Chk4jwI21UDWI%3D&reserved=3D0
> <https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bp=
f/prog_tests/>
> > user_ringbuf.c
> >   [1]
> >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.com%2Ftorvalds%2Flinux%2Fblob%2Fmaster%2Ftools%2Ftesting%2Fselftests%2Fbp=
f%2Fprogs%2Fuser_&data=3D05%7C02%7CShankar.Seal%40microsoft.com%7C0d269a2ce=
1364e2be3fd08dc7f3da157%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638525=
149885870894%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC=
JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DJ8Zhz8R9j%2BaPnAw6uRvOWiY=
%2BW%2BExZRV8u5J1y%2BknsJ0%3D&reserved=3D0
> <https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bp=
f/progs/user_>
> > ringbuf_success.c
>
> Both of those links go to GPL code so I suspect Shankar cannot use those
> links.
> I think the answer is that BPF_MAP_TYPE_USER_RINGBUF is defined for this
> purpose and Shankar can read
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flwn.n=
et%2FArticles%2F907056%2F&data=3D05%7C02%7CShankar.Seal%40microsoft.com%7C0=
d269a2ce1364e2be3fd08dc7f3da157%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%=
7C638525149885875408%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2=
luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DZpGIAzP6toavqQM6f=
63iLFHlM3%2BYc27jCAzaG3lbPMQ%3D&reserved=3D0
> <https://lwn.net/Articles/907056/>
>
> Thanks,
> Dave
>
>
>
>

--000000000000c05ae7061bae99bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 20, 2024 at 11:49=E2=80=
=AFPM Shankar Seal &lt;<a href=3D"mailto:Shankar.Seal@microsoft.com">Shanka=
r.Seal@microsoft.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div class=3D"msg2181938563760855620">




<div dir=3D"ltr">
<div style=3D"font-family:Georgia,serif;font-size:10pt;color:rgb(0,36,81)">
Since I have not heard back on this topic, I am assuming that there are no =
strong oppositions to this idea.</div>
<div style=3D"font-family:Georgia,serif;font-size:10pt;color:rgb(0,36,81)">
<br>
</div>
<div style=3D"font-family:Georgia,serif;font-size:10pt;color:rgb(0,36,81)">
So I am sharing the signature of the proposed user API.<br>
<br>
<span style=3D"font-family:monospace">=C2=A0<code> =C2=A0=C2=A0 /**</code><=
/span></div>
<div style=3D"font-family:monospace;font-size:10pt;color:rgb(0,36,81)">
<code>=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0@brief=C2=A0Write=C2=A0data=C2=A0into=
=C2=A0the=C2=A0ring=C2=A0buffer=C2=A0map from user space.</code></div>
<div style=3D"font-family:monospace;font-size:10pt;color:rgb(0,36,81)">
<code>=C2=A0=C2=A0=C2=A0=C2=A0*</code><br>
<code>=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0@param=C2=A0ring_buffer_map_fd=C2=A0ri=
ng=C2=A0buffer=C2=A0map=C2=A0file=C2=A0descriptor.</code><br>
<code>=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0@param=C2=A0data=C2=A0Pointer=C2=A0to=
=C2=A0data=C2=A0to=C2=A0be=C2=A0written.</code><br>
<code>=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0@param=C2=A0data_length=C2=A0Length=C2=
=A0of=C2=A0data=C2=A0to=C2=A0be=C2=A0written.</code></div>
<div style=3D"line-height:19px;white-space:pre-wrap;font-family:monospace;f=
ont-size:10pt;color:rgb(0,36,81)">
=C2=A0 * @retval 0 The operation was successful.</div>
<div style=3D"line-height:19px;white-space:pre-wrap;font-family:monospace;f=
ont-size:10pt;color:rgb(0,36,81)">
=C2=A0 * @retval &lt;0 An error occured, and errno was set.</div>
<div style=3D"font-family:monospace;font-size:10pt;color:rgb(0,36,81)">
<code>=C2=A0=C2=A0=C2=A0=C2=A0*/</code></div>
<div style=3D"font-family:monospace;font-size:10pt;color:rgb(0,36,81)">
<code>=C2=A0 =C2=A0</code>int</div>
<div style=3D"font-family:monospace;font-size:10pt;color:rgb(0,36,81)">
<code>=C2=A0=C2=A0 ring_buffer_</code>user<code>__write(</code></div>
<div style=3D"font-family:monospace;font-size:10pt;color:rgb(0,36,81)">
<code>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd_t=C2=A0ring_buffer_map_fd, co=
nst=C2=A0void*=C2=A0data,=C2=A0size_t=C2=A0data_length);</code></div>
<div style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:=
monospace;font-size:10pt;color:rgb(0,36,81)"><br>
</span><span style=3D"font-family:&quot;Georgia Pro&quot;,serif;font-size:1=
0.5pt;color:rgb(0,32,96)">Please let me=C2=A0know if you have any questions=
 about this API.</span></div></div></div></blockquote><div><br></div><div><=
div style=3D"font-family:monospace,monospace;font-size:small" class=3D"gmai=
l_default">I think the devil will be in the details. API itself makes sense=
 (you can&#39;t simplify it further or make it much different), in the end,=
 you are just sending an array of bytes into ringbuf.</div><div style=3D"fo=
nt-family:monospace,monospace;font-size:small" class=3D"gmail_default"><br>=
</div><div style=3D"font-family:monospace,monospace;font-size:small" class=
=3D"gmail_default">But the implementation details are what matters. How the=
 notification works. How user space won&#39;t break kernel even if intentio=
nally trying, etc. It&#39;s not clear where you intend to implement this, e=
tc.<br></div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div class=3D"msg2181938563760855620"><div dir=3D"ltr">
<div style=3D"font-family:Georgia,serif;font-size:10pt;color:rgb(0,36,81)">
<span style=3D"font-family:&quot;Georgia Pro&quot;,serif;font-size:10.5pt;c=
olor:rgb(0,32,96)">Thanks,<br>
Shankar</span><br>
<span style=3D"font-family:&quot;Shonar Bangla&quot;,serif;font-size:14pt;c=
olor:rgb(0,32,96)">=E0=A6=B6=E0=A6=82=E0=A6=95=E0=A6=B0 =E0=A6=B6=E0=A7=80=
=E0=A6=B2</span></div>
<div id=3D"m_2181938563760855620Signature">
<div id=3D"m_2181938563760855620divtagdefaultwrapper">
<div id=3D"m_2181938563760855620divtagdefaultwrapper">
<div id=3D"m_2181938563760855620divtagdefaultwrapper">
<div id=3D"m_2181938563760855620divtagdefaultwrapper"></div>
</div>
<p style=3D"background-color:white">=C2=A0</p>
</div>
</div>
</div>
<div id=3D"m_2181938563760855620appendonsend"></div>
<div style=3D"font-family:Georgia,serif;font-size:10pt;color:rgb(0,36,81)">
<br>
</div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_2181938563760855620divRplyFwdMsg" dir=3D"ltr"><span style=3D"f=
ont-family:Calibri,sans-serif;font-size:11pt;color:rgb(0,0,0)"><b>From:</b>=
=C2=A0Shankar Seal &lt;Shankar.Seal=3D<a href=3D"mailto:40microsoft.com@dma=
rc.ietf.org" target=3D"_blank">40microsoft.com@dmarc.ietf.org</a>&gt;<br>
<b>Sent:</b>=C2=A0Wednesday, June 5, 2024 10:01 PM<br>
<b>To:</b>=C2=A0dthaler1968=3D<a href=3D"mailto:40googlemail.com@dmarc.ietf=
.org" target=3D"_blank">40googlemail.com@dmarc.ietf.org</a> &lt;dthaler1968=
=3D<a href=3D"mailto:40googlemail.com@dmarc.ietf.org" target=3D"_blank">40g=
ooglemail.com@dmarc.ietf.org</a>&gt;; &#39;Andrii Nakryiko&#39; &lt;<a href=
=3D"mailto:andrii.nakryiko@gmail.com" target=3D"_blank">andrii.nakryiko@gma=
il.com</a>&gt;<br>
<b>Cc:</b>=C2=A0<a href=3D"mailto:bpf@ietf.org" target=3D"_blank">bpf@ietf.=
org</a> &lt;<a href=3D"mailto:bpf@ietf.org" target=3D"_blank">bpf@ietf.org<=
/a>&gt;; <a href=3D"mailto:bpf@vger.kernel.org" target=3D"_blank">bpf@vger.=
kernel.org</a> &lt;<a href=3D"mailto:bpf@vger.kernel.org" target=3D"_blank"=
>bpf@vger.kernel.org</a>&gt;<br>
<b>Subject:</b>=C2=A0[Bpf] Re: [EXTERNAL] RE: Re: Writing into a ring buffe=
r map from user space</span>
<div>=C2=A0</div>
</div>
<table align=3D"left" style=3D"direction:ltr;display:table;width:100%;table=
-layout:fixed;border-collapse:collapse;border-spacing:0px;box-sizing:border=
-box">
<tbody>
<tr>
<td style=3D"direction:ltr;background-color:rgb(166,166,166);padding:7px 2p=
x;vertical-align:middle;width:1px">
</td>
<td style=3D"direction:ltr;text-align:left;background-color:rgb(234,234,234=
);padding:7px 5px 7px 15px;vertical-align:middle;color:rgb(33,33,33);width:=
100%">
<div style=3D"direction:ltr;text-align:left;font-family:wf_segoe-ui_normal,=
&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif;font-size=
:12px">
You don&#39;t often get email from shankar.seal=3D<a href=3D"mailto:40micro=
soft.com@dmarc.ietf.org" target=3D"_blank">40microsoft.com@dmarc.ietf.org</=
a>. <a href=3D"https://aka.ms/LearnAboutSenderIdentification" id=3D"m_21819=
38563760855620OWA07725e67-648b-119c-8861-9dbdb9eb20cb" target=3D"_blank">
Learn why this is important</a></div>
</td>
<td align=3D"left" style=3D"direction:ltr;background-color:rgb(234,234,234)=
;padding:7px 5px;vertical-align:middle;color:rgb(33,33,33);width:75px">
</td>
</tr>
</tbody>
</table>
<div style=3D"direction:ltr;font-family:Georgia,serif;font-size:10pt;color:=
rgb(0,36,81)">
Thanks Dave and Andrii.<br>
<br>
</div>
<div style=3D"direction:ltr;font-family:Georgia,serif;font-size:10pt;color:=
rgb(0,36,81)">
Per <a href=3D"https://lwn.net/Articles/907056/" id=3D"m_218193856376085562=
0OWAa91303e0-9b67-de3e-e586-f2afaa285d29" target=3D"_blank">
bpf: Add user-space-publisher ring buffer map type [LWN.net]</a>, the API t=
hat you mentioned<br>
&quot;<span style=3D"font-family:Consolas,Courier,monospace">provides singl=
e-user-space-producer / single-kernel-consumer semantics over a ring buffer=
.</span>&quot;</div>
<div style=3D"direction:ltr;font-family:Georgia,serif;font-size:10pt;color:=
rgb(0,36,81)">
<br>
</div>
<div style=3D"direction:ltr;font-family:Georgia,serif;font-size:10pt;color:=
rgb(0,36,81)">
But this is not the desired behavior for our case. We want both bpf program=
s in kernel mode and user application to be able to write to the same ring =
buffer, which can be consumed by a (potentially different) user application=
.<br>
<br>
</div>
<div style=3D"direction:ltr;font-family:Georgia,serif;font-size:10pt;color:=
rgb(0,36,81)">
Assuming no such API exists, do you see any strong reason <b>against</b>=C2=
=A0writing such an API? If not, we would like to implement one in
<a href=3D"https://github.com/microsoft/ebpf-for-windows" id=3D"m_218193856=
3760855620OWAbf2195da-c099-3a66-dbd7-b3c6ed68671f" target=3D"_blank">
microsoft/ebpf-for-windows: eBPF implementation that runs on top of Windows=
 (github.com)</a>=C2=A0and eventually provide a Linux implementation as wel=
l.</div>
<div style=3D"direction:ltr;font-family:Georgia,serif;font-size:10pt;color:=
rgb(0,36,81)">
<br>
</div>
<div id=3D"m_2181938563760855620x_Signature">
<div id=3D"m_2181938563760855620x_divtagdefaultwrapper">
<div id=3D"m_2181938563760855620x_divtagdefaultwrapper">
<div id=3D"m_2181938563760855620x_divtagdefaultwrapper">
<div id=3D"m_2181938563760855620x_divtagdefaultwrapper">
<p style=3D"margin-top:0px;margin-bottom:0px"><span style=3D"font-family:&q=
uot;Georgia Pro&quot;,serif;font-size:10.5pt;color:rgb(0,32,96)">Thanks,<br=
>
Shankar</span><br>
<span style=3D"font-family:&quot;Shonar Bangla&quot;,serif;font-size:14pt;c=
olor:rgb(0,32,96)">=E0=A6=B6=E0=A6=82=E0=A6=95=E0=A6=B0 =E0=A6=B6=E0=A7=80=
=E0=A6=B2</span></p>
</div>
</div>
<p style=3D"background-color:white;margin-top:0px;margin-bottom:0px">=C2=A0=
</p>
</div>
</div>
</div>
<div id=3D"m_2181938563760855620x_appendonsend"></div>
<hr style=3D"direction:ltr;display:inline-block;width:98%">
<div id=3D"m_2181938563760855620x_divRplyFwdMsg" dir=3D"ltr"><span style=3D=
"font-family:Calibri,sans-serif;font-size:11pt;color:rgb(0,0,0)"><b>From:</=
b>=C2=A0dthaler1968=3D<a href=3D"mailto:40googlemail.com@dmarc.ietf.org" ta=
rget=3D"_blank">40googlemail.com@dmarc.ietf.org</a> &lt;dthaler1968=3D<a hr=
ef=3D"mailto:40googlemail.com@dmarc.ietf.org" target=3D"_blank">40googlemai=
l.com@dmarc.ietf.org</a>&gt;<br>
<b>Sent:</b>=C2=A0Tuesday, May 28, 2024 10:42 AM<br>
<b>To:</b>=C2=A0&#39;Andrii Nakryiko&#39; &lt;<a href=3D"mailto:andrii.nakr=
yiko@gmail.com" target=3D"_blank">andrii.nakryiko@gmail.com</a>&gt;; Shanka=
r Seal &lt;<a href=3D"mailto:Shankar.Seal@microsoft.com" target=3D"_blank">=
Shankar.Seal@microsoft.com</a>&gt;<br>
<b>Cc:</b>=C2=A0<a href=3D"mailto:bpf@ietf.org" target=3D"_blank">bpf@ietf.=
org</a> &lt;<a href=3D"mailto:bpf@ietf.org" target=3D"_blank">bpf@ietf.org<=
/a>&gt;; <a href=3D"mailto:bpf@vger.kernel.org" target=3D"_blank">bpf@vger.=
kernel.org</a> &lt;<a href=3D"mailto:bpf@vger.kernel.org" target=3D"_blank"=
>bpf@vger.kernel.org</a>&gt;<br>
<b>Subject:</b>=C2=A0[EXTERNAL] RE: [Bpf] Re: Writing into a ring buffer ma=
p from user space</span>
<div>=C2=A0</div>
</div>
<div style=3D"direction:ltr;font-size:11pt">[You don&#39;t often get email =
from dthaler1968=3D<a href=3D"mailto:40googlemail.com@dmarc.ietf.org" targe=
t=3D"_blank">40googlemail.com@dmarc.ietf.org</a>. Learn why this is importa=
nt at
<a href=3D"https://aka.ms/LearnAboutSenderIdentification" id=3D"m_218193856=
3760855620OWAa2ce2711-cb17-4bc2-687a-a9ff562699c9" target=3D"_blank">
https://aka.ms/LearnAboutSenderIdentification</a>=C2=A0]<br>
<br>
Andrii Nakryiko &lt;<a href=3D"mailto:andrii.nakryiko@gmail.com" target=3D"=
_blank">andrii.nakryiko@gmail.com</a>&gt; wrote:<br>
<br>
&gt; On Tue, May 28, 2024 at 9:32=E2=80=AFAM Shankar Seal<br>
&gt; &lt;Shankar.Seal=3D<a href=3D"mailto:40microsoft.com@dmarc.ietf.org" t=
arget=3D"_blank">40microsoft.com@dmarc.ietf.org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Adding <a href=3D"mailto:bpf@vger.kernel.org" target=3D"_blank">b=
pf@vger.kernel.org</a><br>
&gt; &gt;<br>
&gt; &gt; A common use case of an BPF ring buffer map to use as a queue of<=
br>
&gt; &gt; events generated by BPF programs that can be read in-order by use=
r<br>
&gt; &gt; space applications. I have a scenario requirement for a user spac=
e<br>
&gt; &gt; application to write into a ring buffer (or similar) map, such th=
at<br>
&gt; &gt; events by BPF programs in kernel and user space applications are<=
br>
&gt; &gt; interleaved in the order they were generated, that can be consume=
d by<br>
&gt; &gt; another user space application<br>
&gt; &gt;<br>
&gt; &gt; I would like to implement this new feature in the<br>
&gt; <a href=3D"https://github.com/microsoft/ebpf-for-windows" id=3D"m_2181=
938563760855620OWAebd0315b-dbeb-fe9a-4995-be2944dfe07d" target=3D"_blank">
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.=
com%2Fmicrosoft%2Febpf-for-windows&amp;data=3D05%7C02%7CShankar.Seal%40micr=
osoft.com%7C0d269a2ce1364e2be3fd08dc7f3da157%7C72f988bf86f141af91ab2d7cd011=
db47%7C1%7C0%7C638525149885854034%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM=
DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&amp;sdata=3D=
VEDCtAH%2FtGTBOUmRFzf%2BlPbhyVejY3PoJex5yOmmQQE%3D&amp;reserved=3D0</a>=C2=
=A0project.
 But before I go ahead with<br>
&gt; the implementation, I wanted to check if there is any way to accomplis=
h this in<br>
&gt; Linux today? If not, is there any reason why this should not be done?<=
br>
&gt;<br>
&gt; Yes, there is. See user_ring_buffer ([0], [1]).<br>
&gt;<br>
&gt;=C2=A0=C2=A0 [0]<br>
&gt; <a href=3D"https://github.com/torvalds/linux/blob/master/tools/testing=
/selftests/bpf/prog_tests/" id=3D"m_2181938563760855620OWAf70e3a71-6cdb-43f=
0-53e7-9c0f8a89d2e4" target=3D"_blank">
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.=
com%2Ftorvalds%2Flinux%2Fblob%2Fmaster%2Ftools%2Ftesting%2Fselftests%2Fbpf%=
2Fprog_tests%2F&amp;data=3D05%7C02%7CShankar.Seal%40microsoft.com%7C0d269a2=
ce1364e2be3fd08dc7f3da157%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6385=
25149885863954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi=
LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&amp;sdata=3DTu9BXn%2BHuZvMLRRqC=
6Kvg%2F6V1vVrJ2Chk4jwI21UDWI%3D&amp;reserved=3D0</a><br>
&gt; user_ringbuf.c<br>
&gt;=C2=A0=C2=A0 [1]<br>
&gt; <a href=3D"https://github.com/torvalds/linux/blob/master/tools/testing=
/selftests/bpf/progs/user_" id=3D"m_2181938563760855620OWA4d3a1ba3-0d18-666=
f-cbcb-4394fcfacb21" target=3D"_blank">
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.=
com%2Ftorvalds%2Flinux%2Fblob%2Fmaster%2Ftools%2Ftesting%2Fselftests%2Fbpf%=
2Fprogs%2Fuser_&amp;data=3D05%7C02%7CShankar.Seal%40microsoft.com%7C0d269a2=
ce1364e2be3fd08dc7f3da157%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6385=
25149885870894%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi=
LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&amp;sdata=3DJ8Zhz8R9j%2BaPnAw6u=
RvOWiY%2BW%2BExZRV8u5J1y%2BknsJ0%3D&amp;reserved=3D0</a><br>
&gt; ringbuf_success.c<br>
<br>
Both of those links go to GPL code so I suspect Shankar cannot use those li=
nks.<br>
I think the answer is that BPF_MAP_TYPE_USER_RINGBUF is defined for this<br=
>
purpose and Shankar can read <a href=3D"https://lwn.net/Articles/907056/" i=
d=3D"m_2181938563760855620OWA0d95d0e0-ad28-93ff-96b9-856e99a8f25e" target=
=3D"_blank">
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flwn.net=
%2FArticles%2F907056%2F&amp;data=3D05%7C02%7CShankar.Seal%40microsoft.com%7=
C0d269a2ce1364e2be3fd08dc7f3da157%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C=
0%7C638525149885875408%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&amp;sdata=3DZpGIAzP6toa=
vqQM6f63iLFHlM3%2BYc27jCAzaG3lbPMQ%3D&amp;reserved=3D0</a><br>
<br>
Thanks,<br>
Dave<br>
<br>
<br>
<br>
</div>
</div>

</div></blockquote></div></div>

--000000000000c05ae7061bae99bb--


--===============3573771859435456013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

LS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBmQGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYub3JnCg==

--===============3573771859435456013==--



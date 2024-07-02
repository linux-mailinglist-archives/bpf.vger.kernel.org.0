Return-Path: <bpf+bounces-33587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4521B91EC04
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0B61F2212B
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055FC6FC3;
	Tue,  2 Jul 2024 00:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6Tq6bGY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEEF393
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719881693; cv=none; b=ry2uXgUHUxX3O/ftSHXnNy3NmAo7B1tTLu1ptCrqG+1K0XSlgsBKmzUs1QQcLt0lKkAVdT8FYrzikCZMXeV7XAWJCeBXEV1KEa+F0lEflZeRQMwBExxCB6b3PeN8PH3/S+IKLecHJZ6X1EHTJE+ofpkI0+pR51M6VEYkyP+9LlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719881693; c=relaxed/simple;
	bh=w0krF1dw3c2lA01ir5A4jf5r/0vqF69hNwNzQZSgLjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MojCGAmO4Pe3BXIos93iP1aB3App2MkURswJI0PDRFLxcn4Zfw22ArkGqF/e/tAEhvs9S4GNyBpT5YXEz/6vhMtt2SnN0zBJOJRWHfB32eIFHvcXXVL/vRukO2OJq1kP201jqfppJ1ULvlez0q9GSxh4QVuC6vm3ELOvRKDDfTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6Tq6bGY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70679845d69so2299754b3a.1
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 17:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719881691; x=1720486491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+bbiGQXYWSfjKaagQ1RMDcmnR1qbId2FnkYofjhekU=;
        b=L6Tq6bGY3VZUT1ckHywt6v7n3VsQ6zklPjhHCCFFn4WA5y+4ZOHulJg+PLFqh/2Xsj
         1onBdh0beZ5bbEIlGBzrZnLd24u932lKfZHr9Y62TEsGzTBVQj4H//0GRyCaSV/f2PcO
         rJ8hy4Ta7pzqp1hkJssnrunYpeJQLANvlr0Yu6gCrFEh662nl5BMqi1CWbGWNukGrHRW
         BXxBO3e+eXWpSddem2Uq7LUHGknWkLSDA5U6G7gkZyyHHOvsdib3nRRrAbzpzg30yS9w
         himp2IqpWMK/5Q3K3yxHdXl1iNR1ikJicjd3qwmVmKo47POZTdFKLVmqqjgdCtJLHjey
         p9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719881691; x=1720486491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+bbiGQXYWSfjKaagQ1RMDcmnR1qbId2FnkYofjhekU=;
        b=wQDz7N+JiIqRqpHRigCRw0TVhOB9KoJNyJMJIRU7c85Ms+84KMvvgjCVjvuHWoX+nU
         dxxORMZNm9dmaw2eg3yTWaf0c3UDJ2jSESt4ZaBgiCk2/bjwpd6K90zPwQFQc7kQEwci
         EKagczVaHChUwdh2pW0/wLjG4uqX92qPNd2HGiWnivNEFPVJjLBBcGucAzas/Nhay9Sl
         Tsg5+WisWhiHRb9NAHVtRxmqUoPP6MH7rEVlRFipB9eLnf1T0Yd6nNZkNcj5CLZpU2GR
         WrXVcP9RjC9F4rycHgdPBeIX6Br5Th1kL1hA3O1pMOkPvyInjD+PZnm0FntFbYSbpvyB
         vmCw==
X-Forwarded-Encrypted: i=1; AJvYcCUTEt2xS0bRZaBC1g2kkfzM6qE7tXRnpseRC+XJRbbJ0U57SnigDsyOyeTB0ZmqZhPQ31nsKElaouJEVk/6FkmSERlK
X-Gm-Message-State: AOJu0YxDi87/FXcZZSjrwLn9aOo9bxihbt+c06spkXcJAKUPmpG+YIfl
	ajeCeNkbca9IUDYM9vCzPUYdUUYPkWTqRmln5Ccd2+g1kSqsdBLDT2B1VN0qQE2yq4PWKardtlw
	4J34bKpupx9Q+K10l5iWF3IaHR7U=
X-Google-Smtp-Source: AGHT+IFEfncZWHRf1w7k8NMYB6QVq1XuTPYqOadRpRIb9X8iBTbxdkAi+qDhz9TD7/ofZFvW3eam27XICfzgSQext1A=
X-Received: by 2002:a05:6a00:cd3:b0:706:8ce7:d582 with SMTP id
 d2e1a72fcca58-70aaad620fbmr6691962b3a.17.1719881691049; Mon, 01 Jul 2024
 17:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH0PR21MB19101A296E6A180AD99EDD3898F12@PH0PR21MB1910.namprd21.prod.outlook.com>
 <PH0PR21MB191058745A71A705F199B19A98F12@PH0PR21MB1910.namprd21.prod.outlook.com>
 <CAEf4BzZf=7Sb9Zf7Bt_oJh=Pq6b=03wspmr8iJSY-KRyJVZ3nw@mail.gmail.com>
 <0c4801dab126$7a502fc0$6ef08f40$@gmail.com> <PH0PR21MB191000EA2B7A038CE99C5B5398FA2@PH0PR21MB1910.namprd21.prod.outlook.com>
 <PH0PR21MB19108A5EF85F75C9F273D14798C92@PH0PR21MB1910.namprd21.prod.outlook.com>
 <CAEf4BzaJbjVY-qnjS0=8U_TEwpQTigvbGnBpou+mA6P8DOiuzA@mail.gmail.com>
 <PH0PR21MB19108C4E51658567D704114898D52@PH0PR21MB1910.namprd21.prod.outlook.com>
 <CAEf4BzZjiqarLN9w=9AzQrEvSS+EYF-SAXwajaotsFuJ7PAp8A@mail.gmail.com> <PH0PR21MB191080B6BA61E887EE47B9DC98D12@PH0PR21MB1910.namprd21.prod.outlook.com>
In-Reply-To: <PH0PR21MB191080B6BA61E887EE47B9DC98D12@PH0PR21MB1910.namprd21.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 17:54:38 -0700
Message-ID: <CAEf4BzYYu0HxkJpBEKEnGxAkn+iOnvOQbt_coQjhRLkZQQvSLg@mail.gmail.com>
Subject: Re: [Bpf] Re: [EXTERNAL] RE: Re: Writing into a ring buffer map from
 user space
To: Shankar Seal <Shankar.Seal@microsoft.com>
Cc: Shankar Seal <Shankar.Seal=40microsoft.com@dmarc.ietf.org>, 
	"dthaler1968=40googlemail.com@dmarc.ietf.org" <dthaler1968=40googlemail.com@dmarc.ietf.org>, "bpf@ietf.org" <bpf@ietf.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 11:44=E2=80=AFPM Shankar Seal
<Shankar.Seal@microsoft.com> wrote:
>
> Thanks Andrii.
>
> I am changing the email format to plain text. Hopefully this will work wi=
th the vger mailing list.
>
> >> I don't think the Linux side can/should work like that.
>
> Note that the proposal I made for Windows in previous email is *effective=
ly* the same as the following:
> 1. Load a bpf program that reads data from a user supplied map and then w=
rites the data into a ring buffer.
> 2. User space app populates the data map and then invoke the program usin=
g bpf_prog_test.
>
> Assuming this approach would be considered a valid use of eBPF, I think w=
e can implement the API on Windows as proposed below. I will be happy to wo=
rk with you to build a solution on Linux that is acceptable to you.
>

I'm sorry, I don't think I'll have time to work on this. But what you
describe above about triggering a special BPF program to submit data
to ringbuf a) doesn't need any new APIs (we can do that today) but
also b) it's going to be slow and a bit cumbersome to use, probably.


> Thanks,
> Shankar
> =E0=A6=B6=E0=A6=82=E0=A6=95=E0=A6=B0 =E0=A6=B6=E0=A7=80=E0=A6=B2
>
> From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Sent: Wednesday, June 26, 2024 4:44 PM
> To: Shankar Seal <Shankar.Seal@microsoft.com>
> Cc: Shankar Seal <Shankar.Seal=3D40microsoft.com@dmarc.ietf.org>; dthaler=
1968=3D40googlemail.com@dmarc.ietf.org; bpf@ietf.org; bpf@vger.kernel.org
> Subject: Re: [Bpf] Re: [EXTERNAL] RE: Re: Writing into a ring buffer map =
from user space
>
>
> >> On Mon, Jun 24, 2024 at 8:50=E2=80=AFPM Shankar Seal <mailto:Shankar.S=
eal@microsoft.com> wrote:
>
> >> Here is a brief overview of what we intend to do in the eBPF for Windo=
ws code:
>
> >>  The user space app will not directly write into the underlying ring b=
uffer of the eBPF map. Instead, the user app (via the libbpf API) will send=
 the data via an IOCTL[1] to the eBPF core (a Windows Kernel  Driver[2])  t=
hat manages the ring buffer map. The driver will internally invoke the same=
 code that implements the bpf_ringbuf_output helper function to write the u=
ser provided data buffer into the ring buffer map.
>
> >>I am not aware of how the ring buffer map is implemented in the Linux k=
ernel. But presumably a similar approach could be taken in Linux as well?
>
> >> [1] https://learn.microsoft.com/en-us/windows/win32/devio/device-input=
-and-output-control-ioctl-
>
> >> [2] https://learn.microsoft.com/en-us/windows/win32/devio/device-input=
-and-output-control-ioctl-
>
> I don't think the Linux side can/should work like that.
>
> Also, keep in mind that your HTML-based messages are not reaching mailto:=
bpf@vger.kernel.org. So please fix your HTML set up and continue conversati=
on over mailto:bpf@vger.kernel.org.
>
> Thanks,
> Shankar
> =E0=A6=B6=E0=A6=82=E0=A6=95=E0=A6=B0 =E0=A6=B6=E0=A7=80=E0=A6=B2
>
> ________________________________________
> From: Andrii Nakryiko <mailto:andrii.nakryiko@gmail.com>
> Sent: Monday, June 24, 2024 8:36 PM
> To: Shankar Seal <mailto:Shankar.Seal@microsoft.com>
> Cc: Shankar Seal <Shankar.Seal=3Dmailto:40microsoft.com@dmarc.ietf.org>; =
dthaler1968=3Dmailto:40googlemail.com@dmarc.ietf.org <dthaler1968=3Dmailto:=
40googlemail.com@dmarc.ietf.org>; mailto:bpf@ietf.org <mailto:bpf@ietf.org>=
; mailto:bpf@vger.kernel.org <mailto:bpf@vger.kernel.org>
> Subject: Re: [Bpf] Re: [EXTERNAL] RE: Re: Writing into a ring buffer map =
from user space
>
>
>
> On Thu, Jun 20, 2024 at 11:49=E2=80=AFPM Shankar Seal <mailto:Shankar.Sea=
l@microsoft.com> wrote:
> Since I have not heard back on this topic, I am assuming that there are n=
o strong oppositions to this idea.
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
> I think the devil will be in the details. API itself makes sense (you can=
't simplify it further or make it much different), in the end, you are just=
 sending an array of bytes into ringbuf.
>
> But the implementation details are what matters. How the notification wor=
ks. How user space won't break kernel even if intentionally trying, etc. It=
's not clear where you intend to implement this, etc.
>
>
> Thanks,
> Shankar
> =E0=A6=B6=E0=A6=82=E0=A6=95=E0=A6=B0 =E0=A6=B6=E0=A7=80=E0=A6=B2
>
>
> ________________________________________
> From: Shankar Seal <Shankar.Seal=3Dmailto:40microsoft.com@dmarc.ietf.org>
> Sent: Wednesday, June 5, 2024 10:01 PM
> To: dthaler1968=3Dmailto:40googlemail.com@dmarc.ietf.org <dthaler1968=3Dm=
ailto:40googlemail.com@dmarc.ietf.org>; 'Andrii Nakryiko' <mailto:andrii.na=
kryiko@gmail.com>
> Cc: mailto:bpf@ietf.org <mailto:bpf@ietf.org>; mailto:bpf@vger.kernel.org=
 <mailto:bpf@vger.kernel.org>
> Subject: [Bpf] Re: [EXTERNAL] RE: Re: Writing into a ring buffer map from=
 user space
>
>
> You don't often get email from shankar.seal=3Dmailto:40microsoft.com@dmar=
c.ietf.org. https://aka.ms/LearnAboutSenderIdentification
>
> Thanks Dave and Andrii.
> Per https://lwn.net/Articles/907056/, the API that you mentioned
> "provides single-user-space-producer / single-kernel-consumer semantics o=
ver a ring buffer."
>
> But this is not the desired behavior for our case. We want both bpf progr=
ams in kernel mode and user application to be able to write to the same rin=
g buffer, which can be consumed by a (potentially different) user applicati=
on.
> Assuming no such API exists, do you see any strong reason against writing=
 such an API? If not, we would like to implement one in https://github.com/=
microsoft/ebpf-for-windows and eventually provide a Linux implementation as=
 well.
>
> Thanks,
> Shankar
> =E0=A6=B6=E0=A6=82=E0=A6=95=E0=A6=B0 =E0=A6=B6=E0=A7=80=E0=A6=B2
>
> ________________________________________
> From: dthaler1968=3Dmailto:40googlemail.com@dmarc.ietf.org <dthaler1968=
=3Dmailto:40googlemail.com@dmarc.ietf.org>
> Sent: Tuesday, May 28, 2024 10:42 AM
> To: 'Andrii Nakryiko' <mailto:andrii.nakryiko@gmail.com>; Shankar Seal <m=
ailto:Shankar.Seal@microsoft.com>
> Cc: mailto:bpf@ietf.org <mailto:bpf@ietf.org>; mailto:bpf@vger.kernel.org=
 <mailto:bpf@vger.kernel.org>
> Subject: [EXTERNAL] RE: [Bpf] Re: Writing into a ring buffer map from use=
r space
>
> [You don't often get email from dthaler1968=3Dmailto:40googlemail.com@dma=
rc.ietf.org. Learn why this is important at https://aka.ms/LearnAboutSender=
Identification ]
>
> Andrii Nakryiko <mailto:andrii.nakryiko@gmail.com> wrote:
>
> > On Tue, May 28, 2024 at 9:32=E2=80=AFAM Shankar Seal
> > <Shankar.Seal=3Dmailto:40microsoft.com@dmarc.ietf.org> wrote:
> > >
> > > Adding mailto:bpf@vger.kernel.org
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
> > https://github.com/microsoft/ebpf-for-windows project. But before I go =
ahead with
> > the implementation, I wanted to check if there is any way to accomplish=
 this in
> > Linux today? If not, is there any reason why this should not be done?
> >
> > Yes, there is. See user_ring_buffer ([0], [1]).
> >
> >   [0]
> > https://github.com/torvalds/linux/blob/master/tools/testing/selftests/b=
pf/prog_tests/
> > user_ringbuf.c
> >   [1]
> > https://github.com/torvalds/linux/blob/master/tools/testing/selftests/b=
pf/progs/user_
> > ringbuf_success.c
>
> Both of those links go to GPL code so I suspect Shankar cannot use those =
links.
> I think the answer is that BPF_MAP_TYPE_USER_RINGBUF is defined for this
> purpose and Shankar can read https://lwn.net/Articles/907056/
>
> Thanks,
> Dave
>
>


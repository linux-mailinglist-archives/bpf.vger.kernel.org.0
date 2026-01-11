Return-Path: <bpf+bounces-78502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB94D0FA12
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 20:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3540C30178D0
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 19:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C20352C56;
	Sun, 11 Jan 2026 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkrNUyoh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254C219FC
	for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768159143; cv=pass; b=NjVbQ1zzAGfMxILO26rDyLetw3xW22FmOv6hOu7g+4GD5lmjTqixH4ykbEsDRmwvH1WAKnwGgx0vhISA0yrus+CWonfdpNKGSonzjpRpBjFkBDh9b0F4rvBEkZqVpSlaaDloCyFFFShLPtmO4Jpznxn6VOffuQ+qLdq+ksWFOjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768159143; c=relaxed/simple;
	bh=o3N2ccNOiCXPwAFzm5HRCPw881IHfs+lbmruDzyx/rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V83gXd5mTQlgRMVr4m7VAk2qbKvEt4IRARrok3QW/Uaa++yoOXZIgC/i64dRRYnfCYO7hGx7KaNOeAsnBiIuiURkC8bcRM8GbFTOw/v15hD0fvakZvEgbwnXiQsv7VYpWV0cz9YQlWEzvtIA0vavzwou22UMtc//eHTGDuJoFiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkrNUyoh; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b737450f6so4182e87.0
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 11:19:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768159140; cv=none;
        d=google.com; s=arc-20240605;
        b=gsxO6QXkLPFYqyiDmG4qVSvoe6TWNwf2SRT8EgyU4i8vY1Zyaf+ye0z7D8p0hPj/av
         sRxa59zvUDPyg069BtGeUs40UIHb7kp0woVzMaqvU9xj6rZeFZ3HhSkT4gGExu9Ed9vR
         aML/nCJrSpgXdmLqUArKHz1DqxE6k/u1JX7R/nzL7mTH8zGvpfl/DWf6c4GbiVC7Xe+v
         6HdUuO3DCUN+y7di+ifUx9ZfTOhUt0R6G7Mx188TS0A6zew6NZ3/ZfvyUB4IiRjiGPpM
         lK81QgD6HEZolBHqnRQCylKMdx7vU1dRrS2q/b9CH/gEL1DJg+WRWll7K8G3qET9DqcB
         IImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o3N2ccNOiCXPwAFzm5HRCPw881IHfs+lbmruDzyx/rw=;
        fh=ufu1iHiuuZcN9a6A1Zq/y2pJqUaIR5T1Gx+lsTXglas=;
        b=KAAU6hna1Bh5GXLlzmL3Z45oCBoGtJ/Qjak6hrsivjnIV8HyallhbwKKW/IBWbvMI6
         KXixXvGFYOuzEu4Wml8+x9Vwv/6otYU9+I5Ir6eSZR0EN8yKZGW597Ggj8blWNhenHd1
         nLBczM/DfVhun4MrMYYzG8jFHIfkPB0JXaMHcBobqLlHzs594Fh/MOW9DlAVp2/oARaL
         AjJEChOTIk/48k9Ht3poQ0E0RRRuWVUao+NCrQ/D2McBvVkpcNxj2Jge0/Y684lyGuZP
         bakgbtuLazhAD6UEJ9gERMbeOcJjTJSgqh+YyS5eLIcO80rg3GiJX4T+Q5FEtVZZSBYb
         GBww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768159140; x=1768763940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3N2ccNOiCXPwAFzm5HRCPw881IHfs+lbmruDzyx/rw=;
        b=qkrNUyohZvSHSSQfb1dbFsufEMZV0ZlZClceMW5DVsjpagf5Pvf5wsNdkEjj/UmiQJ
         5W436NtjCigmWPdV0nyuBxBeuyI0DqtjbJpPp1i6wbUM1wT20lyauk2JDBKyC1bjkxBj
         7iAy4DXJ6gjA3XWhygNWWeUK5t6/hkzgRzy9fBqppiHqrXpHwQfdIyIl2uqweFHbLIn5
         lob4ANNeFpvtDsvkEnkXN3ghjRBFX3bEtpdSK1vN68m2OdjSEqTyFIMe4lZiFUy0mdVa
         r66A6h+9FrdJ8xkCHEldeX7mD0NF7BY4S6nc1aUhxiKYDf0eCZeFdbPHYefxgH760T+J
         3JxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768159140; x=1768763940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o3N2ccNOiCXPwAFzm5HRCPw881IHfs+lbmruDzyx/rw=;
        b=M6G/9YMqOqfjXVwDrhTimPAqfP6i9KmhG9w9F1LIltTXUAtobW0QOHSAEc+T2VQU4D
         RoUItVLYaFDcx5RvC7kMQMa14AY8X2d/OeOlqR3nb0N256Z8SWDVpLHhBmR6RCRxfxKZ
         YahiDTmoXbNEW0YVYtzs2Z1Ive64AXVoErNbCCKbIYafKjUfSrsRiMIYWNiW/CRcQ8Yc
         Q51aOxdUBQ16JjOWleC0ipBTPAkVSxhtAfxloUkogqJg5kO+NPJRy+iELiGvVEyhFKae
         9V6VOZIvVJZcd7t8fOn5JaiKOKN/7pDH0sxRx4Zs33jag2IH4SwgDq5wq19akKDbYANv
         gIhA==
X-Forwarded-Encrypted: i=1; AJvYcCXYKRlGvLihPq6pljnKkiwtuz2I6vS1clllKYv+4zzE4ILebK7IJYiDYurRdNxqVL4APE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLLWUDcTF79SbAw195uKES2LSXgMzb420ykIRnkRkJyqfjBjY9
	3HwYP30m39OeuBhfW6VMuKHSss7dNa2DUHE1krJRzXyrbBceZt8Ufh/JP61x9k56l8I1YNApwYv
	rPNmyp3VXWnOrMjxtPrmE4P+xjl8kvBnOKqz4SAJvBeH+7c935oV+xj5BIp4=
X-Gm-Gg: AY/fxX4Nbdt4IaOD+JCrzMP5wylF8Qjz0uiU8IAD36kva2AmV4I9CrRqWYU9AZaBS5I
	dhTRRTTEgx/7r6ptQO7ft6ZB13BT7CkY4YOhTxdfDuq0J492d+oEid/5+aKal3qBxAhjPOIUlVa
	WrBybZE60HGBBeXxl4hfn+kKGQfm4kqpnlrMgyjPHu7flYYVgTHAeaqJcGvij0Ly2hU2DstyRxe
	tFbePGIXsWaKu+hJskbKyLLmD8fElo69yYurX+EeeGf3MFwsOz0rZgIoIizQmycC13Y2lw=
X-Received: by 2002:a05:6512:639b:20b0:59b:57ed:3622 with SMTP id
 2adb3069b0e04-59b87c43391mr83611e87.1.1768159139730; Sun, 11 Jan 2026
 11:18:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223194649.3050648-1-almasrymina@google.com> <43dafae2-e1f1-44ce-91c1-7fc236966f58@molgen.mpg.de>
In-Reply-To: <43dafae2-e1f1-44ce-91c1-7fc236966f58@molgen.mpg.de>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Jan 2026 11:18:45 -0800
X-Gm-Features: AZwV_QjQhMoevwA58NGfYpT2i-RPV2KkpfFJ2IlmuJKbZfsyf_TMKOH2OuGi6DA
Message-ID: <CAHS8izO2fjT3DuqHzQQiF2LUvcAPuR4Spav5Ap9wG=VgsAtDbQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4] idpf: export RX hardware
 timestamping information to XDP
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	YiFei Zhu <zhuyifei@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Richard Cochran <richardcochran@gmail.com>, intel-wired-lan@lists.osuosl.org, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 12:36=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Mina,
>
>
> Thank you for your patch. Some minor comments, should you resend.
>

Thanks, looks like I have reviews and this is on its way, but should I
resend I will fix the minor comments.

> Am 23.12.25 um 20:46 schrieb Mina Almasry via Intel-wired-lan:
> > From: YiFei Zhu <zhuyifei@google.com>
> >
> > The logic is similar to idpf_rx_hwtstamp, but the data is exported
> > as a BPF kfunc instead of appended to an skb to support grabbing
> > timestamps in xsk packets.
> >
> > A idpf_queue_has(PTP, rxq) condition is added to check the queue
> > supports PTP similar to idpf_rx_process_skb_fields.
> >
> > Tested using an xsk connection and checking xdp timestamps are
> > retreivable in received packets.
>
> retr*ie*vable
>
> It=E2=80=99d be great if you could share the commands.
>

I don't have easy repro to share in the commit message. The test
involves hacking up the xsk_rr Sami used for his busypolling patch to
enable xdp metadata and retrieve timestamps, or (what I did) actually
set up openonload with this patch and test onload can get the
timestamps. Let me see what I can do, but it's likely too much context
for someone unfamiliar to piece together.

--=20
Thanks,
Mina


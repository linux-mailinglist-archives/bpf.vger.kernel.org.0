Return-Path: <bpf+bounces-3171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6782673A7C9
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 19:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A796C281A6B
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 17:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F57320682;
	Thu, 22 Jun 2023 17:55:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2CA200D8
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 17:55:19 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DA81FE9
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 10:55:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b5251e5774so38365505ad.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687456516; x=1690048516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZopR+yZdtvW9ytEW4LlTw4JiDHE16+h+InPFvxkvFh0=;
        b=7lkpPd+8vvukUce8Xen/UcMT/6gB/0w6915dlq9c7Js2KRSNTLXD2ksjuqvJB2bPRA
         EJ4O1cfS/sVweeYjTdPxiA/i4DBRsLPMjLgaHO+GaWTtHug0qWsb+TtQFRMIG97R3IBc
         EBkQ6Jtz1C/jT2Wje7FCiUJY2J8Wf0tIAojEpH5EVxEJdSwiviHSWO6wzNg1YkEKyYzd
         1mUTEDw/2HT+u02xYwRWijbKvLzRrYyBKzgWjttGdXWyT0i9MNg3J5ZKbrHjyyQ+OR8C
         /GpXR+cZ262EZiL7k/xK16v5OHuJ+/t1xCWV7KZYiXIouLtYSkimzoH3QECmflwsuSYg
         qHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687456516; x=1690048516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZopR+yZdtvW9ytEW4LlTw4JiDHE16+h+InPFvxkvFh0=;
        b=UDY+xBhDOUy+Ok5BbbDClRM+gVGBwCDcq5phz6oaA/bAMUYhEJ97EW7FY9y72t2mX3
         b7mgpLqlPoVgPZXYl3vTWShWDZFdDjJULxVozRpkavbz2Gfl8dz6pgrBpR75yQiW6rLe
         D0CBalWt7kxoESm7EhZza3Zjhl3df7sGbTzN0QdsufagSF2ZzNDuuoFiBsujHE78pCSn
         s2wUHAeXzuGtIHczASeAchGNUGZo3WL4ppYCfy8i57XC2iRgJrzEqXMIyOha32xadVsI
         k7RQRWUFVoiNVEZWjRU6oXwWAg8pHKWe6F67WrXaO29R7oUPNdR2sKgQoS4TjJMwZNgN
         JITQ==
X-Gm-Message-State: AC+VfDyxMVDYLIE/M4+R2jT12LyKp4EeO0RNwFfjGxJeG3QLQbBVEn3o
	xL9M7Cd2WS8BuSx+UA5XkxMPSs5KDxnmeQmKQScCpO7fITdw+N4qgTQ=
X-Google-Smtp-Source: ACHHUZ6o4w+o6WvKr7BC4dBZ5RerlUd45giKsYUyO0SusX90EgreA/M3yLb+ZfGiA9YbqiuKIpVpnTl71WfZgclnAhc=
X-Received: by 2002:a17:90a:ab8a:b0:260:ea8f:613d with SMTP id
 n10-20020a17090aab8a00b00260ea8f613dmr4794593pjq.20.1687456516226; Thu, 22
 Jun 2023 10:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-4-sdf@google.com>
 <ZJRoI2U1WD83yz/J@corigine.com>
In-Reply-To: <ZJRoI2U1WD83yz/J@corigine.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 22 Jun 2023 10:55:04 -0700
Message-ID: <CAKH8qBv=z0tB2h+TpPzDzMqytMbScyUA=udsY+yL4OWL2icoow@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 03/11] xsk: Support XDP_TX_METADATA_LEN
To: Simon Horman <simon.horman@corigine.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 8:26=E2=80=AFAM Simon Horman <simon.horman@corigine=
.com> wrote:
>
> On Wed, Jun 21, 2023 at 10:02:36AM -0700, Stanislav Fomichev wrote:
>
> ...
>
> > @@ -1137,6 +1145,27 @@ static int xsk_setsockopt(struct socket *sock, i=
nt level, int optname,
> >               mutex_unlock(&xs->mutex);
> >               return err;
> >       }
> > +     case XDP_TX_METADATA_LEN:
> > +     {
> > +             int val;
> > +
> > +             if (optlen < sizeof(val))
> > +                     return -EINVAL;
> > +             if (copy_from_sockptr(&val, optval, sizeof(val)))
> > +                     return -EFAULT;
> > +
> > +             if (val >=3D 256)
> > +                     return -EINVAL;
> > +
> > +             mutex_lock(&xs->mutex);
> > +             if (xs->state !=3D XSK_READY) {
> > +                     mutex_unlock(&xs->mutex);
> > +                     return -EBUSY;
> > +             }
> > +             xs->tx_metadata_len =3D val;
> > +             mutex_unlock(&xs->mutex);
> > +             return err;
>
> Hi Stan,
>
> clang-16 complains that err is used uninitialised here.

Oh, thanks, will do 'return 0' instead!


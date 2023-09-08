Return-Path: <bpf+bounces-9528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C33798B9E
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 19:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EA6281C65
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DB614A98;
	Fri,  8 Sep 2023 17:57:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65ED14A91
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 17:57:33 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FC21FCD
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 10:57:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52e64bc7c10so3153573a12.1
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 10:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1694195846; x=1694800646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u9FMRt0y1aRhgblpOUczRePuNijbbWUyuTWS+WIQ9/E=;
        b=ct/Z7BrFkMTWLDp0pZtFMkn3dWsZlnDoONqW3pHgUzw+FvSFVYILzStpCSsiF8vq6Y
         4lhgqRSZeG+mQUVBRiIUStkFaXruu2eU8VGQABLmu5pE9zXMHqs4ggR+cHDPPuNLNWFu
         +Gv+QUPVWwWXNqetyb8c23GY2RClhGRfHRBQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694195846; x=1694800646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9FMRt0y1aRhgblpOUczRePuNijbbWUyuTWS+WIQ9/E=;
        b=CJWLsQwTd/Hys8Z5+Apq93aaXw2ShGCp5AdKet+c/aftiI76P19fS7DbhSdCDu0oAw
         VsHktDQ8HYOKwTWdpWvbrMX6d5hnxjV7mbZpwqczGkOjuL90cvlrg4sKkJXKSH9+8qiU
         WNWtYhllzwY+bsujqEWR8uLYtzzUEp5C5FiS4uH3MGhWzTgYrToeJ+PurRYOrRzXlEj1
         3TmPj2S+mnfU3CuJs/x0xONDnW2ql+7MSJFy+s5CMAbUq+eysnzvLKL2kFmMMXSln0+q
         PKc3BFm8t1k3jyrw+8xrp2M8pyEkNE32vIr+yzhsIrsapYRa8FEchtAk9DoHC9xe64/X
         TpTg==
X-Gm-Message-State: AOJu0YwAHDMn4ljl/zkahI2ppS1CBb7psTV2qHaaTQF/CCrLjvAZG+BJ
	KRhEwgOf4GsS3SoBD1ruAYFFRwiaViff20YGvDDICQ==
X-Google-Smtp-Source: AGHT+IF8tTr4Pjd4QAICJu+OHsVF2qh0K4stavmCitJ97a8Van3WEbdaZhoiL8edeuxw9uX9z1PqLs10IP1UWlw18Mg=
X-Received: by 2002:aa7:d586:0:b0:523:d715:b7b0 with SMTP id
 r6-20020aa7d586000000b00523d715b7b0mr2645290edq.31.1694195845540; Fri, 08 Sep
 2023 10:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230908135748.794163-1-bigeasy@linutronix.de>
 <20230908135748.794163-3-bigeasy@linutronix.de> <CALs4sv2=ox6ZWj3FUY=0-Zj3uNAOpCLM_vf_dmsVx+ju2S9UUA@mail.gmail.com>
In-Reply-To: <CALs4sv2=ox6ZWj3FUY=0-Zj3uNAOpCLM_vf_dmsVx+ju2S9UUA@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 8 Sep 2023 10:57:13 -0700
Message-ID: <CACKFLin+1whPs0qeM5xBb1yXx8FkFS_vGrW6PaGy41_XVH=SGg@mail.gmail.com>
Subject: Re: [PATCH net 2/4] bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Gospodarek <gospo@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009507a40604dcb572"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000009507a40604dcb572
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 8, 2023 at 9:30=E2=80=AFAM Pavan Chebbi <pavan.chebbi@broadcom.=
com> wrote:
>
> On Fri, Sep 8, 2023 at 7:29=E2=80=AFPM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > bnxt_poll_nitroa0() invokes bnxt_rx_pkt() which can run a XDP program
> > which in turn can return XDP_REDIRECT. bnxt_rx_pkt() is also used by
> > __bnxt_poll_work() which flushes (xdp_do_flush()) the packets after eac=
h
> > round. bnxt_poll_nitroa0() lacks this feature.
> > xdp_do_flush() should be invoked before leaving the NAPI callback.
> >
> > Invoke xdp_do_flush() after a redirect in bnxt_poll_nitroa0() NAPI.
> >
> > Cc: Michael Chan <michael.chan@broadcom.com>
> > Fixes: f18c2b77b2e4e ("bnxt_en: optimized XDP_REDIRECT support")
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 5cc0dbe121327..7551aa8068f8f 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -2614,6 +2614,7 @@ static int bnxt_poll_nitroa0(struct napi_struct *=
napi, int budget)
> >         struct rx_cmp_ext *rxcmp1;
> >         u32 cp_cons, tmp_raw_cons;
> >         u32 raw_cons =3D cpr->cp_raw_cons;
> > +       bool flush_xdp =3D false;
>
> Michael can confirm but I don't think we need this additional variable.
> Since the event is always ORed, we could directly check if (event &
> BNXT_REDIRECT_EVENT) just like is done in __bnxt_poll_work().

If we have a mix of XDP_TX and XDP_REDIRECT during NAPI, event can be
cleared by XDP_TX.  So this patch looks correct to me because of that.
Or we can make it consistent with __bnxt_poll_work() and assume that
XDP_TX won't mix with XDP_REDIRECT.

Handling a mix of XDP actions needs to be looked at separately.  The
driver currently won't work well when that happens.  I am working on
an internal patch to address that and will post it when it's ready.
Thanks.

>
> >         u32 rx_pkts =3D 0;
> >         u8 event =3D 0;
> >
> > @@ -2648,6 +2649,8 @@ static int bnxt_poll_nitroa0(struct napi_struct *=
napi, int budget)
> >                                 rx_pkts++;
> >                         else if (rc =3D=3D -EBUSY)  /* partial completi=
on */
> >                                 break;
> > +                       if (event & BNXT_REDIRECT_EVENT)
> > +                               flush_xdp =3D true;
> >                 } else if (unlikely(TX_CMP_TYPE(txcmp) =3D=3D
> >                                     CMPL_BASE_TYPE_HWRM_DONE)) {
> >                         bnxt_hwrm_handler(bp, txcmp);
> > @@ -2667,6 +2670,8 @@ static int bnxt_poll_nitroa0(struct napi_struct *=
napi, int budget)
> >
> >         if (event & BNXT_AGG_EVENT)
> >                 bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
> > +       if (flush_xdp)
> > +               xdp_do_flush();
> >
> >         if (!bnxt_has_work(bp, cpr) && rx_pkts < budget) {
> >                 napi_complete_done(napi, rx_pkts);
> > --
> > 2.40.1
> >
> >

--0000000000009507a40604dcb572
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN5SbgY2wCS+qZOvJU0DQuCpT4pgNeiv
wQmFsBw6hI3fMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDkw
ODE3NTcyNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBDdkkccYmp/IFyiwY263uLcCGbpWa+XzVCgQbwIyJ4ThM751B1
6mdllIPdqQmFHynGJmcYy26fUKpiygILokYmeJiZhFVTHde3Dehq/eK8wjBbySH7X+S1Mfz0Z83l
mLEmlg1vXfj5x7zRvInkCI+pFwfqaR57XnGCgT6ioJwgqW2Njn8QUaNNdpo5g+ib6Y5RzDFtYEa3
xS93+Ism+cZidIqbzRa9/98CW/82RBvhSTwQ6f4zGJePyUHK0ZhoX5LzhwC+4NIpjAaPCvcpGssR
3+O+wU2lZ1rEmYDNRsRyBPnXOhZvGRYVqf7UOpP6ObHVR+54DTW5pemSScih+KLp
--0000000000009507a40604dcb572--


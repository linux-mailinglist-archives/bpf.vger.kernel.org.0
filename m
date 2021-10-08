Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFF0426D4D
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 17:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242765AbhJHPP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 11:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242662AbhJHPP3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 11:15:29 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4A1C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 08:13:33 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j5so40696601lfg.8
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=G+Iq7iy1GRMddIdrCBUu2NHbxR3JoNjA4F7Y0VPhz5I=;
        b=o6BcWptbP4Nwnxc3AZ9h8SMcCwG8bBM/wE2/Rq5rH5zOaadUVUFEqwFR8fSb66ZAuP
         IoZ8u441rLXj9HsEW8+YJVBRPs+n59jKrZ1XihlPUPyN7SLhXd7uS3/b6VxDZ0iWsTKc
         4lbwZBm468iD/Zn22bRt3ClyEmWC+kFjUL+m9BpBts8KdmGINW6iyvRopExTvqnEZD/L
         Ytn0TLgCdjmDqu/YYEbrmbcQ1WN2/iLM36DgRokyeFN8/zvKr/Vcd5Evl2jQJ6JPQeb3
         MqskXHiwsEsAjiXHz058fwlaC6Hr0YvYhHMp5SE3/LXLI3N/gSPcnAcLGe2XOVes5SSm
         uzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=G+Iq7iy1GRMddIdrCBUu2NHbxR3JoNjA4F7Y0VPhz5I=;
        b=EJ4jUi6hbWpUpBkFI5gyj5HKIX3TOqpvL0QjfM0DUNO3O0MljfUkD4Mq5DREc0Mnwv
         Wd5dbkxAQ/vftxdZloO7wErLwFzqZRP6LJim5RYAgpnjfJ6BD6/LnYI+fzOgIH5B4tmy
         hW+DlaBbREgpJYxFUuRRSLKRedUb9aSTpVnaVvmaQGjbvyYok3rBk5jh6CANqQ1pA5ix
         Kmtv/O8kSDMNQtbyWdbOLwcBLIbJIgPXwZ4yx2RpSp3/2QQVOxFjv4wdUVgVHT7stYok
         GriWfFNtBe+Qt7rA8Grrs0PINTXmRo/755Fr7bgXd9JtdB0cveSQ0BEOGXee5GsDPNeS
         /+5w==
X-Gm-Message-State: AOAM5308MmujA+egScGihsGGc/3SOpOm61VMnv71ji4l2yznw4tXFvxz
        d7XBTy0XSE50xHXIOLzklzPCiJ9BxF7CMgVIpZM=
X-Google-Smtp-Source: ABdhPJxag2yh2V0cZnj+nUUqftmZHXeLAnsiREusGnoCEG16lx+L7JmSD0W+1+an6WdJz6zBEF2SF+i2ta6NpPctiyE=
X-Received: by 2002:ac2:568c:: with SMTP id 12mr10290751lfr.135.1633706011801;
 Fri, 08 Oct 2021 08:13:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:719:0:0:0:0:0 with HTTP; Fri, 8 Oct 2021 08:13:30 -0700 (PDT)
Reply-To: alimaanwari48@gmail.com
From:   Alima Anwari <kekererukaya6@gmail.com>
Date:   Fri, 8 Oct 2021 16:13:30 +0100
Message-ID: <CAAnXHzRCF1=G-w3sYHDGQT9ruopfSPMf=EbHsZ2vDNrQmhejWQ@mail.gmail.com>
Subject: =?UTF-8?B?QnVlbiBkw61h?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--=20
Hola querido amigo, soy Alima Anwari de Afganist=C3=A1n, por favor responde
De vuelta a m=C3=AD, tengo un problema urgente que compartir contigo. voy a
estar esperando
para su respuesta.
Gracias.
Alima.

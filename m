Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D954828D8
	for <lists+bpf@lfdr.de>; Sun,  2 Jan 2022 01:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiABApi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Jan 2022 19:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiABApi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Jan 2022 19:45:38 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4E1C061574
        for <bpf@vger.kernel.org>; Sat,  1 Jan 2022 16:45:38 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o6so121946364edc.4
        for <bpf@vger.kernel.org>; Sat, 01 Jan 2022 16:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mrxhTGCiJdlGC+eJy5UXznUx973zEpGxFnhRGTjwkGI=;
        b=fCj6ucvPc4BmnEGzgbyDJjrhZ8BQAvmRqjq1Fc5MCTsVd3dSLELjzorU+1q1zr9M8I
         liNyQkV7JwOuw5B6GafpqEMpOPuZG1UEXp6M/C1fpeUSR68t7+LudoFFbLSUYiRnhUUg
         TdWss5gRIFZLTEXv1B9TPID4OZlqUDQ8XRd9lls5I1RvzM05US3P3u9v/+5RCzpoEUBN
         Q5W1bG14lGUoeRoLgsRNLgQOfiOwdSrNXujmb0O2eh28rCM1/4NCzHFIz5jeTsgEo+dv
         CQbx25oAddddzzKsDSpHBXkYyyCtlETv18yoVgG9W1hiRLnW9bF7beKu6JywkBVC6UWW
         MZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mrxhTGCiJdlGC+eJy5UXznUx973zEpGxFnhRGTjwkGI=;
        b=78MlA/EhdAfkC/LIdf68IVqXPkG+AMsILwGP40Do0/W0enaoCD1oiH3REiE5/L4nCS
         508Ix9040Lh3ZHSIkA4BtdcEmaPP1qcIZitsRf0OlTP9x9fuH/IJWQegcBD5ylCP+Lc6
         XDfQe05W01oqF3gAtpRKl8jkMXgE6NHBJY+NP6EoojY+Ime3lvw9FG6dKM+konF77xze
         B01ZHuR4DC+3D4LHfGD5FC4p3rPn6GxkqG6glPMv1KuGvB+MWW58/YcdmH52gepHgMGB
         IfbltqGRjUa9FtdYlTdMIhI0c0Yhs+p1+wfQ5LIfaSkUPDB2jsHUIp5qV0Wax+Sl6+rF
         EXVg==
X-Gm-Message-State: AOAM532VHioVKC5KTCG5N4dsLtLeh7FqnlIf8kzljyrfmmbiG0FXnleF
        LheZR68tDX2t9pYhIa8JfNmr4FDIPTnz66V2xHA=
X-Google-Smtp-Source: ABdhPJwzHYimNc7k2kLgXcLnY5590/oFwRKqquqa9Yj8sEilUAyy9XLVfOXiTBjGY35VdqZgwF+Z4Cbt7y4d/lk3M0k=
X-Received: by 2002:a17:907:1dc7:: with SMTP id og7mr25105403ejc.303.1641084336414;
 Sat, 01 Jan 2022 16:45:36 -0800 (PST)
MIME-Version: 1.0
Reply-To: asad1ibn@gmail.com
Sender: yassinelabo1981@gmail.com
Received: by 2002:a55:c994:0:b0:139:90cb:1a2e with HTTP; Sat, 1 Jan 2022
 16:45:35 -0800 (PST)
From:   Mr Asad Ibn <asadibn22@gmail.com>
Date:   Sat, 1 Jan 2022 16:45:35 -0800
X-Google-Sender-Auth: XyCdmLVoPU1lYgdGCJnYkq-9oPI
Message-ID: <CAMYD-0bg0018Yxw38k79zm6qUAAye2YAdnFoLCkdMWUP5dMv_g@mail.gmail.com>
Subject: Dear Sir/Madam
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I=E2=80=99M Barrister Assad LBN.from Burkina Faso, I am sending this brief
letter to solicit your support. I have a Client who is an Indian, his
name is Mr. Dasya Kahaan. He was a gold dealer here in Burkina Faso
before he died six years ago when he went for kidney transplants in
his country India.

He deposited the sum of $5.5 Million dollars in one of the legendary
banks here in Burkina Faso. I have tried all I can to get in touch
with any of his friends or family members but no way.

So i want you to apply to the bank as his Business partner so that the
bank can release Mr.Dasya Kahaan. fund into your bank account. I will
give you the guidelines on how to contact the bank and we have to do
this with trust because I don't want the bank to transfer the fund
into the Government treasury account as an unclaimed fund, so I need
your response.

Warm Regards,
Email.asad1ibn@gmail.com,
Barr.Assad LBN.

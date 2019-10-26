Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1330FE5EB1
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2019 20:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfJZSmO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Oct 2019 14:42:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37250 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfJZSmO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Oct 2019 14:42:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id p13so3196455pll.4
        for <bpf@vger.kernel.org>; Sat, 26 Oct 2019 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=+pUCwMw0bp6t9+incf6kf82pqWqXRfoOQ0MAJqkoLgI=;
        b=YjawuznejfBEfvkpQELvzCVAPNLadqBg+wsjEh7t38cig6hWMf8Cd+CfuRJhPZbhf2
         9R6zWQr7i1oc5p0sn6MOpNFze8FMpSfC/G8SdP5luQuoWJsOR4ONyLLklXQMi89V8Hjq
         Ybgqk3RZ53rb0Qjo9iN3zxDp/vXIm4Da1xBn4v1yNVdjP+uEoKtA0CeDNl87cVj2oTKq
         Ee65PRikFFSqCIfQFS0qi0D+ROZURWlPCcE7sfSyATEg6BzUEb6avHXE2aZmZWaDUmdg
         AMK4NA2SuF9TmJBtj/nPPWaU0nsgoo/6weJ7xuhob/cl3wZAxDT39ItUURySMYcIYH8m
         yQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=+pUCwMw0bp6t9+incf6kf82pqWqXRfoOQ0MAJqkoLgI=;
        b=DWeKJhuVhe4HjFBMSAjUWwRBcE/HKqf/4lbdqCbvyBhzqaK5oUzuxsNOyxKzzXQAR2
         Cym1vnAjYXOo525LxpuVehJyEy20zkPPX6lbL56KA1KBN4BLfNqahZOcSUQbRp+fa871
         5h4ZwFYbQsb970zrTB/TAYLLhsOvDtwYYaRG6HpVrVDhOcpWTz2/2tq267JZy5inyYca
         dyT1FXHVYVb4zas/NNqeRUe+sdg2G7i3nQUVQsigkqUgjBRob1wYRWMiEZPLU6im/87I
         Yk8LBHubRZzxGkT0ZryuAr5VfT+Np4cryxP5lB9JABsv89UuRlidJwgi4mACrShYb9lK
         nZvA==
X-Gm-Message-State: APjAAAVFDZ8oT4PLD3u9Sm0jon3CFHJGiXCEGii5ZfJMasPQMtCrz5Zl
        zTjutDGayrdtuVcduJ+71fF8Mg==
X-Google-Smtp-Source: APXvYqw1t8yDc5FGwNtOxkMmz1zB2cM5/0ECTYGbRXmQH3WJhzhJ8BMB8JTkmpnfKo5OG2nm4tOGwg==
X-Received: by 2002:a17:902:6944:: with SMTP id k4mr10922717plt.175.1572115332989;
        Sat, 26 Oct 2019 11:42:12 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id x10sm5722604pgl.53.2019.10.26.11.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 11:42:12 -0700 (PDT)
Date:   Sat, 26 Oct 2019 11:42:08 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH] bpftool: Allow to read btf as raw data
Message-ID: <20191026114208.49e35169@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20191025200351.GA31835@krava>
References: <20191024133025.10691-1-jolsa@kernel.org>
        <20191025113901.5a7e121e@cakuba.hsd1.ca.comcast.net>
        <20191025200351.GA31835@krava>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 25 Oct 2019 22:03:51 +0200, Jiri Olsa wrote:
> On Fri, Oct 25, 2019 at 11:39:01AM -0700, Jakub Kicinski wrote:
> > On Thu, 24 Oct 2019 15:30:25 +0200, Jiri Olsa wrote: =20
> > > The bpftool interface stays the same, but now it's possible
> > > to run it over BTF raw data, like:
> > >=20
> > >   $ bpftool btf dump file /sys/kernel/btf/vmlinux
> > >   [1] INT '(anon)' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3D(=
none)
> > >   [2] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64 e=
ncoding=3D(none)
> > >   [3] CONST '(anon)' type_id=3D2
> > >=20
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org> =20
> >=20
> > Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com> =20
>=20
> [root@ibm-z-107 bpftool]# ./bpftool btf dump file /sys/kernel/btf/vmlinux=
  | head -3
> [1] INT '(anon)' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3D(none)
> [2] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64 encodin=
g=3D(none)
> [3] CONST '(anon)' type_id=3D2
> [root@ibm-z-107 bpftool]# lscpu | grep Endian
> Byte Order:          Big Endian

Thanks for checking! I thought the on-disk format is fixed like the
ELF magic number. But if two bads make a right then all is good =E2=98=BA=
=EF=B8=8F

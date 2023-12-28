Return-Path: <bpf+bounces-18702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E474181F43B
	for <lists+bpf@lfdr.de>; Thu, 28 Dec 2023 03:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE361C217DB
	for <lists+bpf@lfdr.de>; Thu, 28 Dec 2023 02:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA82A1106;
	Thu, 28 Dec 2023 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBTjK1cX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1786910E5
	for <bpf@vger.kernel.org>; Thu, 28 Dec 2023 02:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-427ca22a680so28452021cf.3
        for <bpf@vger.kernel.org>; Wed, 27 Dec 2023 18:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703732364; x=1704337164; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IMOq4OMqUvpQ7/UPrJZGFJZoiq21IeclF3jYzw2V6K0=;
        b=WBTjK1cXly6kN20cU2cFqnffnf+FIumAT7FJDGRHoyPqNDaY1H4UmtaxX900AVEBED
         Yv+t634Rxi2UDKAYg1trj36HYr6rh1bJ6qJP7THy8kZYBAHZLPm8ShyF/l9liOStHctD
         7SUfQ5J1fSs+XRYbzuK4NrHDrQI76917SKEXvIw6gY/jRFkmLsugXOPddv8oOpOj1HF2
         2FEZcD6A0MFJKyWX9AaSq11ovyHO8vpJxebjFNBRGIKG1v3W1v/v5H2pzeYfEtqxnkzc
         QIUNn3IQACGcnw5yvaradoe31zusIOlgCjiV6Xg3bPjRiVd/KmM+9QWtk3YxmOZHmeMN
         b63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703732364; x=1704337164;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMOq4OMqUvpQ7/UPrJZGFJZoiq21IeclF3jYzw2V6K0=;
        b=k6uCGVDsOsgTXItF3LQnKUwhLMAkHz6M7Y8Nys1NMKdZhe4RErKQZ8XXt1kXPMJssN
         tPqaEUSOSc+kL3WGcCjWal8JPJIgW+3ck39vOV807BvuN9auyBI+FDFTtXXMFIZMf9rv
         lMnC5CIasry8G7C01adnYjRDsCBIFC81VqPmeAlK3xzfRxR+wteGm7jyBrhs8GTmcfCr
         /CI2GdDeCr/o+Tdyp1IKJr96rGXYdQWAzgZfrmX0v4liDkvZChgeLHNtkcp3wRdDrrfu
         q+jkYhgZmpngehmehc5jRk9Xqu+JK8XCgSNfrZ5OMVc93MOo3TWqdJky+Zk/ASgjxtNY
         FCcg==
X-Gm-Message-State: AOJu0YyukuOYUAfOSmdAfmahIsLL423fb8JOAzS5T7lafJ6wggWrBtjn
	PL0mDHYCnw/i+9vlX9AzMg1Nlv7pq4CpNRR/FqCEbNky4hM=
X-Google-Smtp-Source: AGHT+IFDrNtdCt0v5a8g8ZwEBH0jBmgzhj7fHXZPtAn9HY0SpnUiugrkIbuKrSTHh1vRgYqAXQQv/L2/Soq/kin07JU=
X-Received: by 2002:ac8:5a93:0:b0:427:f62e:f0d1 with SMTP id
 c19-20020ac85a93000000b00427f62ef0d1mr791355qtc.96.1703732363767; Wed, 27 Dec
 2023 18:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Wed, 27 Dec 2023 18:59:12 -0800
Message-ID: <CAK3+h2z-aymvqqCnuh_LgdF_PnOBRd5PxF7LQxHcQ4uoEirsDQ@mail.gmail.com>
Subject: progs/test_tunnel_kern.c:802:43: error: use of undeclared identifier 'FOU_BPF_ENCAP_FOU'
To: bpf <bpf@vger.kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"

Hi,

When I make the bpf-next master branch bpf selftests, which failed
with error below, seems related to commit 02b4e126e6 bpf: selftests:
test_tunnel: Use vmlinux.h declarations ?

  CLNG-BPF [test_maps] test_tunnel_kern.bpf.o

progs/test_tunnel_kern.c:30:13: error: declaration of 'struct
bpf_fou_encap' will not be visible outside of this function
[-Werror,-Wvisibility]

                          struct bpf_fou_encap *encap, int type) __ksym;

                                 ^

progs/test_tunnel_kern.c:32:13: error: declaration of 'struct
bpf_fou_encap' will not be visible outside of this function
[-Werror,-Wvisibility]

                          struct bpf_fou_encap *encap) __ksym;

                                 ^

progs/test_tunnel_kern.c:741:23: error: variable has incomplete type
'struct bpf_fou_encap'

        struct bpf_fou_encap encap = {};

                             ^

progs/test_tunnel_kern.c:741:9: note: forward declaration of 'struct
bpf_fou_encap'

        struct bpf_fou_encap encap = {};

               ^

progs/test_tunnel_kern.c:765:43: error: use of undeclared identifier
'FOU_BPF_ENCAP_GUE'

        ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_GUE);

                                                 ^

progs/test_tunnel_kern.c:778:23: error: variable has incomplete type
'struct bpf_fou_encap'

        struct bpf_fou_encap encap = {};

                             ^

progs/test_tunnel_kern.c:778:9: note: forward declaration of 'struct
bpf_fou_encap'

        struct bpf_fou_encap encap = {};

               ^

progs/test_tunnel_kern.c:802:43: error: use of undeclared identifier
'FOU_BPF_ENCAP_FOU'

        ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_FOU);

                                                 ^

progs/test_tunnel_kern.c:816:23: error: variable has incomplete type
'struct bpf_fou_encap'

        struct bpf_fou_encap encap = {};

                             ^

progs/test_tunnel_kern.c:816:9: note: forward declaration of 'struct
bpf_fou_encap'

        struct bpf_fou_encap encap = {};

               ^

7 errors generated.


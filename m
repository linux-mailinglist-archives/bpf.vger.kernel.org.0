Return-Path: <bpf+bounces-15947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E0A7FA69C
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 17:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424B2281A32
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B70D364D2;
	Mon, 27 Nov 2023 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHUdwmUC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED1FD2
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 08:37:40 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfc3f50504so11182895ad.3
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 08:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701103060; x=1701707860; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0T38/mseEE3Cb/l22arsNn9zfTOU+4K9hiCdKK5dla4=;
        b=QHUdwmUCcKxaUyUWoP0Fr/+JwubTTHG/PqBhpZsi8axMnY9dByEjKgq67VhjqTVwYZ
         QBOLJrWR81Iaa1fa+nHGRafSeYWnPrSrosp7aQOP20sxNja88t9GUf+rmo7ncJBECfmU
         fIpnHP1nQwaiCE0y0s4BV2BQ7/MqwEWpjc4rG5wtcaKI1NrHk08AjH+czD//a/7zF2fY
         C0oQ/Oj7Oo/h+6ZEBSuIaZ+fVCijcy2jEVhmH+FnZY4umwUhO8mIHGIjhhuU/LwcHtw1
         CjVKbXPX4nfCZMq3b7Ky/Q4fN1e5cFEn/w9k8/oz+QS9CocOLMKGK99O8Z0mm0iequMp
         qjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701103060; x=1701707860;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0T38/mseEE3Cb/l22arsNn9zfTOU+4K9hiCdKK5dla4=;
        b=PVk/GmA/fobwVkw1lWOSDJmCbmrzqnWmYHeu9gyGoRGqU8iLNMkC1C6N2hKxtAeVUx
         5g00Ot0VYvwX/hmNKYzcPVYfVKkVFeaF/9wdNQS4bvFnlPrc3/nFPW3gChMob5DZkGCS
         qRo4PPIAn/meTrG3y3gD+znCxpMsl2h1nMNVhJbnRZZcwBFZYUJBaEoCOlMdYoWkZrLf
         hakcmwJfruSlgb07+4fwsDO97/GO3uPeTZYxGzCF70rEsboBkr5xM0KGSbvvAfbF0PJI
         mLKpzgayT9vvj6lOGaFmwYW0pdZPnMnSiFChSGVEvATwAjTURSsCnZIofMCnlT/hpZB4
         m+tA==
X-Gm-Message-State: AOJu0YywDJ0FFH8SY7EZU8NMzWhElQIm5pOiNt/l79Ra+UsWg7RL11FK
	+uArNvPMBFvm6sdFGO7/5ET4QVhENzU=
X-Google-Smtp-Source: AGHT+IHazyllzxHMB68q2NETQKomSG4lmtzFijIcT7QryBORIh8qkVmA9/oFfEo/DRtJ30Pqw9HE6A==
X-Received: by 2002:a17:902:b28c:b0:1cc:3fc9:1802 with SMTP id u12-20020a170902b28c00b001cc3fc91802mr10323776plr.61.1701103059924;
        Mon, 27 Nov 2023 08:37:39 -0800 (PST)
Received: from DESKTOP-6F6Q0LF (static-host119-30-85-97.link.net.pk. [119.30.85.97])
        by smtp.gmail.com with ESMTPSA id iw11-20020a170903044b00b001c726147a46sm2405043plb.234.2023.11.27.08.37.37
        for <bpf@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 27 Nov 2023 08:37:39 -0800 (PST)
Message-ID: <6564c5d3.170a0220.8a666.5fcd@mx.google.com>
Date: Mon, 27 Nov 2023 08:37:39 -0800 (PST)
X-Google-Original-Date: 27 Nov 2023 11:37:37 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: raulthaddeus418@gmail.com
To: bpf@vger.kernel.org
Subject: Building Estimates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: **

Hi,=0D=0A=0D=0AWe provide estimation & quantities takeoff service=
s. We are providing 98-100 accuracy in our estimates and take-off=
s. Please tell us if you need any estimating services regarding y=
our projects.=0D=0A=0D=0ASend over the plans and mention the exac=
t scope of work and shortly we will get back with a proposal on w=
hich our charges and turnaround time will be mentioned=0D=0A=0D=0A=
You may ask for sample estimates and take-offs. Thanks.=0D=0A=0D=0A=
Kind Regards=0D=0ARaul Thaddeus		=0D=0ADreamland Estimation, LLC



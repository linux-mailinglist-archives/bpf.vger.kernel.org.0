Return-Path: <bpf+bounces-13477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C667DA15B
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1726C1C2118A
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 19:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4AE3DFE9;
	Fri, 27 Oct 2023 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qb8MCI/S"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEFA3D98F
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 19:32:38 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AF018F
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 12:32:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c41e95efcbso343241666b.3
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698435155; x=1699039955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWT6rg+UcGuVHCGktF1X9nMLt5S5rmKf4Xsx5qvsANI=;
        b=Qb8MCI/SE2t09YH08xsRPe7xvIDqvL4YihTNMkSt2rdMW/Dpmkj7WvvfbWvactJv1w
         mra5/BgWYRmmcK4QXvh8DDvCBQ1YtH+UHMMvnXaIq2T1sNqsnHZXsLru1aFepAOPfxna
         DTNH668VklYK5WsqmObTVftG6fYPibXxN06+C157bBpeQtKiePh5ITJsTg8S/Y9lOc2K
         SLcjr3gY2S2eO3BdkSuc9qU5yANyRJ4bf3VQmokP6P2nq059gFycvmOU+bx9alwG6hnZ
         q0lBMgpJLY8wfPjIhtmRnVmw1miRlhuy3CKN+TKb8U/k9LFvBhPNY4idEgAf4b147jSy
         KmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698435155; x=1699039955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWT6rg+UcGuVHCGktF1X9nMLt5S5rmKf4Xsx5qvsANI=;
        b=Snk0ZDLPqqDdDnRY1VBvhton2Bfwcp/M+918WGQlpEQKtLYCehdlzf9AZDXn0Vv0+n
         fBlVAUSm7rCkZFcJhqUC/TECnOUJqWgU5H4BwEQQtJPPha8CVmM7syRRmYRH0DtY7McY
         sdd8tCa1cZZ1fFfS5lVU8Y5tIG2QFoePFm6QLQGHdJ8Izi4aKvr7xoAQUkkTgc6qp3KU
         JQZWPuvFF1wRq3SFfptdyemnN9oAh3g6zlUfuiUo7RrEvmDtSIipBvvvu80fgnE4r7gL
         OF14WokYDJt2Kbfz+CKtKhQSF+mGtx0cSlHzUdmy0EBCZ5boufZYHHcsFEy7SLsTcMpz
         s/rQ==
X-Gm-Message-State: AOJu0Yw5iVDGQOcXceHlVDq96oixhrvENBRbvWX4Oq9vAmc6ul++3Od+
	p2rWuKgpXOXejRIHCKS3geneUL0f1c4RZMvKz0SRww==
X-Google-Smtp-Source: AGHT+IHAODo9hINKXNlQvGgAqxNPpRnNjd4AA89Jgp1KLx343fQyHwwoszpkk3UnOGcXvbD6V54sQTKCIm/OR/KX2/4=
X-Received: by 2002:a17:907:a0a:b0:9bf:b129:5984 with SMTP id
 bb10-20020a1709070a0a00b009bfb1295984mr2459494ejc.77.1698435154557; Fri, 27
 Oct 2023 12:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com> <eda2f651-93f7-46c5-be7e-e8295903cc1e@lunn.ch>
In-Reply-To: <eda2f651-93f7-46c5-be7e-e8295903cc1e@lunn.ch>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 27 Oct 2023 12:32:22 -0700
Message-ID: <CAFhGd8rSw7RRXTh0XE6EekPKeka34k5RT93gzqvP8s=PntCdsA@mail.gmail.com>
Subject: Re: [PATCH next v2 0/3] ethtool: Add ethtool_puts()
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, 
	Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Dimitris Michailidis <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Louis Peens <louis.peens@corigine.com>, 
	Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, Landen Chao <Landen.Chao@mediatek.com>, 
	DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>, 
	intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com, 
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 5:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Changes in v2:
> > - wrap lines better in replacement (thanks Joe, Kees)
> > - add --fix to checkpatch (thanks Joe)
> > - clean up checkpatch formatting (thanks Joe, et al.)
> > - rebase against next
>
> Please could you explain the rebase against next? As Vladimir pointed
> out, all the patches are to drivers/net, so anything in flight should
> be in net-next, merged by the netdev Maintainers.

OK, should v3 be against net-next? I opted for next as a catch-all.

>
>     Andrew

Thanks
Justin


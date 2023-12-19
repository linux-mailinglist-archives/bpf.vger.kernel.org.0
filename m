Return-Path: <bpf+bounces-18320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5076818E10
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 18:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338B81F281BE
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35594225D9;
	Tue, 19 Dec 2023 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iGUtjMxO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570B36AE6
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3e4637853so93915ad.0
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703006859; x=1703611659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdBXHobU/TDJkZyR8l3Y3KrInvE9xX6bF3D3uGhwm88=;
        b=iGUtjMxOKhHRHLdb4Ivi53xjL/Iru7ZW/uMHRUB6gVhNlWgKsk1956IJ3tj4uznkEy
         doegLK9lscrQM4ZAZHbo1KiCw3D+Trb7UwBa4q0f7wDqTzWBbMEE7iq6XOl0ixPmA+3Y
         XitK52NpzO8W6t+Z7G8IOGVO8RoeGAbsw+Y+PAY5iC8UrhvZ/9fHZTWFzQ6pl7BXaUBA
         w8Wv/Uj0q/1mYOwmTHAXJfsFDacBsMjew5LSob+1wEK0IpcAuOXkgZpNnBWZx+waN5vL
         WIgtIws5DuNbOky2cu62ooyEv6KcL5Q8pu9dEiHptQok0rGTRLZwknq7Bn4jtArEZERw
         EWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703006859; x=1703611659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdBXHobU/TDJkZyR8l3Y3KrInvE9xX6bF3D3uGhwm88=;
        b=Fo7tB2nWuJzFdF7pZ5YWu0ZM2+v2sDWp6BlJVbNcx7FM/AjN3QAJnOi+anh0Dt0JwE
         f9aT5lo2hPCXLzZb6PqUnfcX0iZnPIubTMcwQdeI1vaWepkum9U+S8j4R1rsVeGRi2UT
         NMmEsaW8f6UwXkpzwdH3hZ6V8j9yF4mFN3aykXohaBFohmWRC24Ms/bhlRmQ3KN8zUFl
         SW3WIjLt/nO7G011fRLdeODSvWpxxl9QJyK4zZNqu4YxO7dFSVxs27c5tAsS4UBRFH3X
         DBpQt7E+8rBoX8pvlu2bZUGdacadWll1sah+jHKNqOzdy1LYgS+K0o+tIn4rJccrzs40
         s6MA==
X-Gm-Message-State: AOJu0YwwfCNW+qZjFunc2CyxNjldb50qIz2ceny0L9rQSjBTe/Rpemcb
	st2Wo5vGJDdCEsllanzSF6DAv3AdqcPSmZ4PWs1v0FCbUrn6
X-Google-Smtp-Source: AGHT+IGixb9h/6OmozmM25gvtdpu7j71DlG4O9g5PVgtzDGnD2/Nd968UnfjYfedN5Vcl4WrP6WiADKs98SeHLycHzE=
X-Received: by 2002:a17:902:cec6:b0:1d3:ce75:a696 with SMTP id
 d6-20020a170902cec600b001d3ce75a696mr211169plg.5.1703006859127; Tue, 19 Dec
 2023 09:27:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214020530.2267499-1-almasrymina@google.com>
 <20231214020530.2267499-3-almasrymina@google.com> <20231215185159.7bada9a7@kernel.org>
 <CAHS8izMcFWu7zSuX9q8QgVNLiOiE5RKsb_yh5LoTKA1K8FUu1w@mail.gmail.com>
 <84787af3-aa5e-4202-8578-7a9f14283d87@kernel.org> <CAHS8izOeCdA+WVRYbieTqaCyadARsOpYttAXh7Lhu-B7RC3Tmg@mail.gmail.com>
 <20231218140645.461169a7@kernel.org> <CAHS8izOZ3c_3hretPBhowW5u-o5r4+WBeG3VVg_k32PUhAZqHA@mail.gmail.com>
In-Reply-To: <CAHS8izOZ3c_3hretPBhowW5u-o5r4+WBeG3VVg_k32PUhAZqHA@mail.gmail.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Tue, 19 Dec 2023 09:27:27 -0800
Message-ID: <CALvZod6oCPk1tJLyffGJ1acJvo7wG72ymm8AePnGi=T=h4sehw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 2/4] net: introduce abstraction for
 network memory
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michael Chan <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, 
	Russell King <linux@armlinux.org.uk>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Jassi Brar <jaswinder.singh@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Ronak Doshi <doshir@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 2:39=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
[...]
> >
> > You didn't address my feedback :|
> >
> > struct netmem which contains struct page by value is almost as bad
> > as passing around pretend struct page pointers.
>
> Sorry about that. I misread your original request as 'here is
> something else you can do if you want', not something that you feel is
> critical. Honestly I missed the subtlety and the approaches seemed
> roughly equivalent to me. I will respin after the 24hr cooldown.
>

Jakub's suggestion aligns more with the encoded_page approach as well,
so let's proceed with that. Waiting for your respin.


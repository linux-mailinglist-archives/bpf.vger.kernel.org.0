Return-Path: <bpf+bounces-16999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 654DE8085BB
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 11:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB41F227AA
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280E835260;
	Thu,  7 Dec 2023 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njLwgueQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803084C95;
	Thu,  7 Dec 2023 10:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B60C433C7;
	Thu,  7 Dec 2023 10:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701946082;
	bh=mnW/y6nXu5tGf4aEpGvE7GdOvchE6NCkqKjTKz4fXwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njLwgueQPMVqMY1mUjUe1pvV4+OHWT1ZvJNs7uxomTu8Dm/ta/UU3O7ennmc97qcc
	 Pm7hMxXfSTnpp0LmBwpJSY9kpBtqGA7fh53+GSBeV6lAuuVnMCKH2pyFocu89s1YkX
	 MbZ52KwIxp+cyfM94UZ84zgyK8fh16M6FpNUbgy4Q96ZD4n6068Yc8Z8kyB7j5Mk95
	 gRQSdTBFeknv4ju7hXWhgGz/bd/T34brckot0jvbVU0eqhtHEVLlxzKOcv90DBWwfD
	 QXtzww7AP2wYyn1Ab1KPyOaqviSxM6ZbkoU+g4SkrD6URa7Eea0tRD1lS9+vvkTcVi
	 s7AZ0cJSKixeQ==
Date: Thu, 7 Dec 2023 10:47:55 +0000
From: Simon Horman <horms@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	haoluo@google.com, jolsa@kernel.org, kuba@kernel.org,
	toke@kernel.org, willemb@google.com, dsahern@kernel.org,
	magnus.karlsson@intel.com, bjorn@kernel.org,
	maciej.fijalkowski@intel.com, hawk@kernel.org,
	yoong.siang.song@intel.com, netdev@vger.kernel.org,
	xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v6 06/13] xsk: Document tx_metadata_len layout
Message-ID: <20231207104755.GD50400@kernel.org>
References: <20231127190319.1190813-1-sdf@google.com>
 <20231127190319.1190813-7-sdf@google.com>
 <20231202170952.GB50400@kernel.org>
 <CAKH8qBvk695byc6TdXyxWR9RmQa+_-0OQAvEsxgOgT6O0amN0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKH8qBvk695byc6TdXyxWR9RmQa+_-0OQAvEsxgOgT6O0amN0g@mail.gmail.com>

On Mon, Dec 04, 2023 at 08:48:46AM -0800, Stanislav Fomichev wrote:
> On Sat, Dec 2, 2023 at 9:10 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Mon, Nov 27, 2023 at 11:03:12AM -0800, Stanislav Fomichev wrote:
> > > - how to use
> > > - how to query features
> > > - pointers to the examples
> > >
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >
> > ...
> >
> > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> > > index 205696780b78..e3e9420fd817 100644
> > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > @@ -1,3 +1,5 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > >  ===============
> > >  XDP RX Metadata
> > >  ===============
> > > diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
> > > new file mode 100644
> > > index 000000000000..4f376560b23f
> > > --- /dev/null
> > > +++ b/Documentation/networking/xsk-tx-metadata.rst
> >
> > Hi Stan,
> >
> > could you send a follow-up patch to add an SPDX identifier here?
> 
> Hmmm, I vividly remember adding it here after your initial comment :-/
> Will send a follow up, thank you for catching it!

Thanks, these things happen :)


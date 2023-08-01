Return-Path: <bpf+bounces-6605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D376BCE9
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECDA281B5C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 18:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09106235BB;
	Tue,  1 Aug 2023 18:48:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619F4DC77
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 18:48:51 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61502D62
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 11:48:41 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b9f3b57c4fso75368a34.1
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915721; x=1691520521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQAbJDerUlyQlHf1jSIoWyuxn5TGn42tyHmHZ8lOjYA=;
        b=dZ5ZtDYPfxzMUtXpB0P5lTrMtYNZpcjOiHw9nQl00zgi2aIPhljQx0UbJxTPLm3FZT
         vSdKkfdfnf/VZ1WWjLFA+gOih0wO3rGdrU99HIZNE+YfPpCFNn5+MHswjkrAn8ony5OZ
         snvnx2Wg+HGMkNOQVXRQdrDCa9hkEnFW848HQXwQBAHu4kB2pcgK9dE3xwtIcHWhIOqj
         W47OSujvk4aB/pb4BtfemJd3ixX24sCR39+e/+b3Md6peicHXhFogygbpfVwWbfpAV3v
         OEX9ZegobY8kq/oXSL/gpYaWpcicUcb0B2fiqnc2vtw5IpYK7p4LEtTgI2fBqVG1IEWs
         rdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915721; x=1691520521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQAbJDerUlyQlHf1jSIoWyuxn5TGn42tyHmHZ8lOjYA=;
        b=eBheaxLTCgdR48Lp0R+Z4FfAEBEiS+KIjOInJCe6bFZAt0iQ6Ipft8w+NRskA//xJf
         QR9hF0UrPysfU4eH2Osa8jnanXeiE6HlI6V3L0GvoG/PeaHuL8ZnSrHdsY8GXR7R2Ipx
         HVCLLy5DuwrfzxRjWLoDAZToe7MJ9OewclK+Flj137JgmUIDyCgOr1jYdwuYXtSTXEFP
         Zykne6hrzWnuTkCsejWDcyADRYl3EhoDLbJGOzp0GJraH/THxeEJHxJlQMTWdOws0UL0
         qR8imsAvypyAV4sYOh/rJLIVScKoTnoJCAeY844JdnWELT72zL0ysJEmFFZQV01gPWdF
         tbiQ==
X-Gm-Message-State: ABy/qLZbiOrUdnEmP3b7zs46vadJTBMaoA/kP7gNHEBp8oXK8OyRnm/G
	XPXAX4tD+FaKREpGIngFjDxtu7kArbMQUIRFkGrBhw==
X-Google-Smtp-Source: APBJJlH4cRFkwbN+YB7mbc1RshczQGk5rkF7BXLU5bN3kMqh1okhqgAf4kDPo10MJcT6014eWGGppF5iRG91T1FaON0=
X-Received: by 2002:a9d:7cd1:0:b0:6b7:5777:f63e with SMTP id
 r17-20020a9d7cd1000000b006b75777f63emr11282137otn.9.1690915721080; Tue, 01
 Aug 2023 11:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801155355.11885-1-tuananhlfc@gmail.com>
In-Reply-To: <20230801155355.11885-1-tuananhlfc@gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Tue, 1 Aug 2023 11:48:29 -0700
Message-ID: <CAKH8qBtcrWYGGar378i21OKVHcVVwqg-EPbpSyNc50t0RLuM0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] samples/bpf: Fix build out of source tree
To: Anh Tuan Phan <tuananhlfc@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, bpf@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 8:54=E2=80=AFAM Anh Tuan Phan <tuananhlfc@gmail.com>=
 wrote:
>
> This commit fixes a few compilation issues when building out of source
> tree. The command that I used to build samples/bpf:
>
> export KBUILD_OUTPUT=3D/tmp
> make V=3D1 M=3Dsamples/bpf
>
> The compilation failed since it tried to find the header files in the
> wrong places between output directory and source tree directory
>
> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>

Acked-by: Stanislav Fomichev <sdf@google.com>


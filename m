Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5438C430F3
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2019 22:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388825AbfFLUX6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jun 2019 16:23:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43835 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388207AbfFLUX6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jun 2019 16:23:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id z24so6749796qtj.10
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2019 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=VkQAk94Ge0qPIQosJvnCX3sqqpgBJ/mS9uh8sxkVDMY=;
        b=UKKENOaJQwhp2kCs1cEs+W/wKCPoQOv31D10SE5NYt+ujeE5WeX1Wgw/BVVdAMxCyh
         H9i57ivMLV516UQkYyg2ZeIpgrFomoxZnhfya75oBbRSQKvLn9tgdejYyfXYhPwNqxhh
         r//PB6nOGc/YQh95zIeNumYpIfkCkJVyWmOr2BMSiOCgJdyNj/fx0Kw5IgewUrOkw5UM
         Pyg8dCOeH5ntmP2tAHc0qEpsEl0Y7g5C3Z1pXIHZoVutd8GMNbv4EUbsxRM7dlIkdxPa
         LLyycNFvX4VdppDy3XQ0V2ZGJtSzJEnYAPBf4v1AUf2zGQOG0y6Oecoy8+ClaHw0WRAJ
         +AwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=VkQAk94Ge0qPIQosJvnCX3sqqpgBJ/mS9uh8sxkVDMY=;
        b=cO1YOYDW1JhYcFpprm0Su/mAimBhmeUIeu13WfUvHYuYBrrPQgg4X9GU44/Y8j/T6m
         kKemdcbWbvK+AIsmH4w/JDKmdAO3009y/zas+Cm4HX6BqiqqDEozJH5m28V2bKBL/XBa
         IjmoBzbb0vPP8Yvcd1lf7qas3am/lVuCA5YuqLpwbrIDXIEZwRWKGbiFd6iQzCMtewUs
         4IMsNDd6G8lR3xCcq56Zd9C+nWWpcMC/tzjplDxpmODEr3ydAQuVqO7B9jTsspxS5aGo
         7id0e9DHI55Eis4Oe9I1wgpsu7yN+aQ9b/Avkjq3c+B/puj8/Ddzd8nOjS+YDtQxwKdQ
         QF5A==
X-Gm-Message-State: APjAAAUl2vb3X0mQjmuVM4Zk45nJJiWojKgMPeIfBDlJPKyNaGuTu7bo
        PuYJ2X3jLVOeOd+19zM4WLGSkA==
X-Google-Smtp-Source: APXvYqyPZNuGmnycKeKF0o0zCKOmnD9TYU2AjUPGkH6zRoRPPTpmPO4UQSNRXm3wmkkzEKsXm+nWyQ==
X-Received: by 2002:a0c:bd1d:: with SMTP id m29mr375832qvg.181.1560371037471;
        Wed, 12 Jun 2019 13:23:57 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o33sm446679qtk.67.2019.06.12.13.23.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 13:23:57 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:23:52 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Maxim Mikityanskiy <maximmi@mellanox.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jonathan Lemon <bsd@fb.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Maciej Fijalkowski <maciejromanfijalkowski@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/17] libbpf: Support drivers with
 non-combined channels
Message-ID: <20190612132352.7ee27bf3@cakuba.netronome.com>
In-Reply-To: <20190612155605.22450-8-maximmi@mellanox.com>
References: <20190612155605.22450-1-maximmi@mellanox.com>
        <20190612155605.22450-8-maximmi@mellanox.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 12 Jun 2019 15:56:48 +0000, Maxim Mikityanskiy wrote:
> Currently, libbpf uses the number of combined channels as the maximum
> queue number. However, the kernel has a different limitation:
> 
> - xdp_reg_umem_at_qid() allows up to max(RX queues, TX queues).
> 
> - ethtool_set_channels() checks for UMEMs in queues up to
>   combined_count + max(rx_count, tx_count).
> 
> libbpf shouldn't limit applications to a lower max queue number. Account
> for non-combined RX and TX channels when calculating the max queue
> number. Use the same formula that is used in ethtool.
> 
> Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
> Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
> Acked-by: Saeed Mahameed <saeedm@mellanox.com>

I don't think this is correct.  max_tx tells you how many TX channels
there can be, you can't add that to combined.  Correct calculations is:

max_num_chans = max(max_combined, max(max_rx, max_tx))

>  tools/lib/bpf/xsk.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
> index bf15a80a37c2..86107857e1f0 100644
> --- a/tools/lib/bpf/xsk.c
> +++ b/tools/lib/bpf/xsk.c
> @@ -334,13 +334,13 @@ static int xsk_get_max_queues(struct xsk_socket *xsk)
>  		goto out;
>  	}
>  
> -	if (channels.max_combined == 0 || errno == EOPNOTSUPP)
> +	ret = channels.max_combined + max(channels.max_rx, channels.max_tx);
> +
> +	if (ret == 0 || errno == EOPNOTSUPP)
>  		/* If the device says it has no channels, then all traffic
>  		 * is sent to a single stream, so max queues = 1.
>  		 */
>  		ret = 1;
> -	else
> -		ret = channels.max_combined;
>  
>  out:
>  	close(fd);


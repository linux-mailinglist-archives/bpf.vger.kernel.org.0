Return-Path: <bpf+bounces-52092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D346A3E307
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 18:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94F73AF32B
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CC82139CB;
	Thu, 20 Feb 2025 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeIBpr/F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF72139C4;
	Thu, 20 Feb 2025 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073552; cv=none; b=Oq73gXZ/Mq8l6RHc6MSgOIDb0WGWJkyagZB/3908/6g7GyZ9cGXR9JehtmlTFsfQkvjd3xwTtUoFSj0SV1IWM40ppGIFi9/Ugoby4Xg+OGt0zHp2yDdOysjnbs1jyQ1C8klgYDSwWO2QfX8SFFqrufULTzS1iJ8oyH7I3QWa9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073552; c=relaxed/simple;
	bh=HA+OKXmo2pTz/MtjCaiQYYkjLWNpX9GASSMj+UYvcXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4b1x+NlaFVkitsvSQSaR/ZbYlao7N/xb14gssHXxAM8YJ+LXI/MCEwgQB0WvrghwlkyWvTEkbXUjcjmruyeEYyc6gZlQg99w9D/zaCTuTUU6bMtbj0ZaaNDiuwoVRos0RbKfvUID110KF0/hgV44mNdSdgR7mW6jhjWQDnqQNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeIBpr/F; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2210d92292eso35408445ad.1;
        Thu, 20 Feb 2025 09:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740073550; x=1740678350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rt+51pdymN1363nprBW4r3PR8+yt8RTRn0YtVbZze+k=;
        b=EeIBpr/FNdTOeLH1hf4QTgxsz0v++sHazQN54e/3KOpcAhjPlrDcQpe4ROksWA92FE
         d0dbnEZNz5y9Rs5seHiKApvcGfBN8J1lXvGGjCNz8qBru8QEjJ8edQjA/ilXeAdBuQMD
         H56CJ4mQBWrSQMIgWXLDbwTtZHtztxWPv9fKc85c2YoxRpbMBonejOH3ecvdGBZj5Dg7
         OwVC6b8xJqLPJowcLYwjWmMZszcYy2CXbGixF6hwclE/Tgne+lNkBkuv/XTlEG/NSSBZ
         DqNnOzmoFgkziJFPgWHJiHdDzv7H+ygQ6HKRsssBoTt6k87BK0SOjKCtIFoLi6EfMztY
         aIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073550; x=1740678350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rt+51pdymN1363nprBW4r3PR8+yt8RTRn0YtVbZze+k=;
        b=K6VC/LdAl6nj74Xzcbpr3UBYMrZNNCiqckH56qiZuacvZI6o8WdUUBoBnHFI23XUWs
         MHc1/nYcSi8Z/y/rnRcC+wr1Fe7+45PPM9AAjL7pkZtBmeBRVBZyEci/TtcCulMg/Szi
         OxZLGyx14k4liz1AysJjRO5ZNMfr+ZkNl/9p6ex/0XP6xBpkDdD3S9TCRXvxrsrBPaNE
         VnfmDuV/taSvbKVq+qgtGsEMR/tlcmi6s56fF/f460GvizAygpVeeh5h9+r59fqJ0Dov
         Bp3SGTCle5Hnj9LXF+cNPFNDEg4EQL799aHb0SjIEwDGWqkWKNDi2Fmp9Pfv29OVpitG
         zzTw==
X-Forwarded-Encrypted: i=1; AJvYcCVjhs4zUL/GkDmLxBSJvjnI3lTAFkXsrxgnd0QfA66LbGFi+iMF0nPfP8BWSpIe8nLh/2+rKYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5IeFNnvz/VAuizYS29NyXNZIBCfi7DcRpsNgkTcbgJhlsCpW
	66/XttlpsjY5BKtsUHlBjR5oGTB0ndLjKxo0gaXAtFr9cCPubxo=
X-Gm-Gg: ASbGncsc3yjsZx35g5lFEo8AiKUKmytyPXAmjh7AA0cIIbsa21p7dyFFtvAVE2ql+rI
	csb1gxB4NG3ms+8TeB1RsfBSKfd6U7fFW7e8YQWr0onEiTGfMJnCPmXoAp117AbQmcs0JHcNXcw
	MlRorLka7/avuUzi6Qb0b9KxpwTzk7eV3broPPuDN4TOD0BtvGhLKCPqo2UCEDxmW6g5xkVDsCo
	tgXw2dexG8/AODJNDtECP1WtEdZz+/DJdUGJ5Z8cwREjW9DKizg2/mqOxabOLzD2bQ+y0sXW2fX
	En3/Pk2CY9F/GE4=
X-Google-Smtp-Source: AGHT+IEAe0Lzj8hBIFUkPCdfAD/4Rz1ex1JmHG9Mbsgs4pOVrfZWHq6SZEDZwHKkV8BBcPEWirYzUw==
X-Received: by 2002:a17:903:2f8d:b0:216:6c77:7bbb with SMTP id d9443c01a7336-2219ff50e37mr559815ad.17.1740073550098;
        Thu, 20 Feb 2025 09:45:50 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22120093e41sm77182045ad.93.2025.02.20.09.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:45:49 -0800 (PST)
Date: Thu, 20 Feb 2025 09:45:48 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org,
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next 1/6] selftests/xsk: Add packet stream
 replacement functions
Message-ID: <Z7dqTLVxnVcO3YyF@mini-arch>
References: <20250220084147.94494-1-tushar.vyavahare@intel.com>
 <20250220084147.94494-2-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220084147.94494-2-tushar.vyavahare@intel.com>

On 02/20, Tushar Vyavahare wrote:
> Add pkt_stream_replace function to replace the packet stream for a given
> ifobject. Add pkt_stream_replace_both function to replace the packet
> streams for both transmit and receive ifobject in test_spec. Enhance test
> framework to handle packet stream replacements efficiently.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 29 +++++++++++++-----------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 11f047b8af75..1d9b03666ee6 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -757,14 +757,15 @@ static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stream)
>  	return pkt_stream_generate(pkt_stream->nb_pkts, pkt_stream->pkts[0].len);
>  }
>  
> -static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
> +static void pkt_stream_replace(struct ifobject *ifobj, u32 nb_pkts, u32 pkt_len)
>  {
> -	struct pkt_stream *pkt_stream;
> +	ifobj->xsk->pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
> +}
>  
> -	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
> -	test->ifobj_tx->xsk->pkt_stream = pkt_stream;
> -	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
> -	test->ifobj_rx->xsk->pkt_stream = pkt_stream;

[..]

> +static void pkt_stream_replace_both(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
> +{
> +	pkt_stream_replace(test->ifobj_tx, nb_pkts, pkt_len);
> +	pkt_stream_replace(test->ifobj_rx, nb_pkts, pkt_len);
>  }

nit: maybe keep existing name pkt_stream_replace here? and add new
helper pkt_stream_replace_ifobject to work on particular ifobject?

static void pkt_stream_replace_both(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
{
	pkt_stream_replace_ifobject(test->ifobj_tx, nb_pkts, pkt_len);
	pkt_stream_replace_ifobject(test->ifobj_rx, nb_pkts, pkt_len);
}

This should avoid touching existing call sites.


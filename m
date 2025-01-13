Return-Path: <bpf+bounces-48668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9797CA0AF37
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 07:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715823A12A3
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 06:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57AA231A4D;
	Mon, 13 Jan 2025 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mr/cOPQh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA501B4236
	for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736749126; cv=none; b=uxI5QICf/tN86GPlgN1CCRm3scFagUetCUjBSP6bgkI65fRXO8M8y3+x8Fb2ZIdVSmLkjWgbh08uZIMOy2dA8M10hNt4AmPE1dvEon0r7Uv7wpdPxv7uvZdhjuDmWFlrouYgRYQY1wZnK8N/fazoOCIJVRadj79HemKkkgQvmxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736749126; c=relaxed/simple;
	bh=LUrrlU4BNkR/ay/fSfOJeTi1DTX6YT5sJQ7H0bsPWk4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g/ugAEmt8+vF/nGsGoQuyGg8wjNjUilVGQyhliSuRyp7gp3ZNOd/Quhut0J9kzN/fNpZU/ZCr7zlAIKFC7Uk2Wqfx2O9P4cUio2Yl7VuJ8atfboa5SjOXrvh9axdYJKJqVNg7HFzSyOAmhZ2P3OT2I0M3dnWy2dHjEC10EduPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mr/cOPQh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso7027015a12.0
        for <bpf@vger.kernel.org>; Sun, 12 Jan 2025 22:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736749123; x=1737353923; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6S+t9FaG2NoF2nwQgSa+JvhqmiyhhbiLGkuYyDyovfo=;
        b=mr/cOPQhgnEwP9P4rcQmeR2eP6cfh2iLhzQvXZBMr7rB2iXcRM12k73s9jnS1Bo/Ry
         u+hXS6sGlkDrk5miIYorX/3xDOfZBm9e5TZxuYkhnbQlmucNGHTTyI9uywbgEl9Pgaqc
         U6NNGCRA2vUmJbKCussoS3SCbTdwP3foSRIUXtBD+wrgl1VzS20Fm2g9aFX+7dr787sM
         xBHFQPAvCQ1J8qr/NU8i44D2hFA3NqA12H5zvV7K1MQjuTfUaVsEuT4RH1XlCNticw0W
         MW+TqN6EfpvCfigoys+InJLhe19/M8QoFzrNzW53kB+7CfgFYoRQboDBbj3uqfSiYsb2
         iJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736749123; x=1737353923;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6S+t9FaG2NoF2nwQgSa+JvhqmiyhhbiLGkuYyDyovfo=;
        b=PX91f15DoLkYCPyNqCUHGyUyNpkRCAN7YuQi3NtAZVuRZyLctVgL58wDufTXrdk7Iw
         IuiFASmCCFl1ob4up4X9e6Pg41PJlOlOkPEKxMyAf2DdkP0RlaOICbH6/C/9nL2EvRVt
         Q6NFkaLRUav+IStw3pGP9qZ/NGs5wNyt8cv0L/Qk/p0Aw5zqLrHjpc9OGCn65EfcsYyU
         25ANQcykQRR9s7LwP0uhsELGIaX5RLcpcIos0qp6bkBZxe6FiyL5YtsxUdv887LsWqwX
         o30BeoAG3oFgUiZAHqh/2gOOocoM4fWzt7q6Iio15POe/L4gfywIOYBUaQ10sGCFBHkM
         i+Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWcjSPvbxZFJuwjL2eap3MBu/oioOQqKlA7OsP0VNtzZoAmIShkDQNGR08KiODv2/WL0KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFvmodorGDC8xjTR5iq+3c349rR9woCQDmdu2HWoWceF4IKqi5
	lszmC5Y8H+p6rahwDZQjo9Wd4qiKj+EbYIg6Djnl6pi4hG/psIjVXMMUFazD5zc=
X-Gm-Gg: ASbGncsyPy6a9t29mMLuVGTBhxCrPGh/lhFAGSvvpl7RIi+koNhr5kVXA/swNkt6fCE
	7Hz8OwoB2+hVAN8JNxgjTa818dO+Uv3LJbGlX8iNp/auWhOM1RUMrXzR3nwBOLW5cipPwjpT8ob
	Pfj4gP8127L4HOTDCoS3so887SBWdNMPdd2FpPOW7SLbnedcSRrgIZENenrgHLCb+j2brh5vMJh
	dpp1Lu0E6HHH0KOOVPFMs2yC+H7VONV3jw5QEglYtnyecA2xj/aqHUDyUzMBw==
X-Google-Smtp-Source: AGHT+IEF+9I/nmlTuNhL+jsv7WcG7fafEtH/1G6wbIJb2hKurpya4UqUE3HWDQiZJqimw76RM48otA==
X-Received: by 2002:a05:6402:34d2:b0:5d1:1f2:1143 with SMTP id 4fb4d7f45d1cf-5d972e1a602mr17851264a12.18.1736749123084;
        Sun, 12 Jan 2025 22:18:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c366sm4523124a12.17.2025.01.12.22.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:18:42 -0800 (PST)
Date: Mon, 13 Jan 2025 09:18:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Louis Peens <louis.peens@corigine.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Quentin Monnet <qmo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] nfp: bpf: prevent integer overflow in
 nfp_bpf_event_output()
Message-ID: <6074805b-e78d-4b8a-bf05-e929b5377c28@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "sizeof(struct cmsg_bpf_event) + pkt_size + data_size" math could
potentially have an integer wrapping bug on 32bit systems.  Check for
this and return an error.

Fixes: 9816dd35ecec ("nfp: bpf: perf event output helpers support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/netronome/nfp/bpf/offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/offload.c b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
index 9d97cd281f18..c03558adda91 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
@@ -458,7 +458,8 @@ int nfp_bpf_event_output(struct nfp_app_bpf *bpf, const void *data,
 	map_id_full = be64_to_cpu(cbe->map_ptr);
 	map_id = map_id_full;
 
-	if (len < sizeof(struct cmsg_bpf_event) + pkt_size + data_size)
+	if (size_add(pkt_size, data_size) > INT_MAX ||
+	    len < sizeof(struct cmsg_bpf_event) + pkt_size + data_size)
 		return -EINVAL;
 	if (cbe->hdr.ver != NFP_CCM_ABI_VERSION)
 		return -EINVAL;
-- 
2.45.2



Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF58102EC6
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 23:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfKSWDU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Nov 2019 17:03:20 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:41655 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfKSWDT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Nov 2019 17:03:19 -0500
Received: by mail-lj1-f172.google.com with SMTP id m4so20203041ljj.8
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2019 14:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=hkXsADjEOdlZ3YiKrCkRrx58YtFi1M6caFsielcQFFg=;
        b=q7RQyIw/akRBQYATHpyvF6sPlZP0+lRSZFkKhlbOJBfKQYyCldLCrHUlBUW3HTEODQ
         lgnyW2VdcXZdHP/TxSv/lxQ9Qw3/UJQK7kckSMyTrHS3HX105JEd+0chhg04zw4H64cS
         ENAZPHxec/j/9CmqijHU44dFqUR9J5oyKICGWW/ZDSgBstvdlmGJ99cE7urJyOTQ6tuq
         hbBIy+LY2mkgR4DlRLJGW7imD0D6Vmnyl1KceTJjeiZT9siqxk1pCbYZr2aZFJvnfluZ
         Yd+xtEyvKeubFn5yFYvECZFAx50FyscC+PbZgUCKkkNG33ixkGB7Vr0Qy8Pj8R9nZmgw
         oF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=hkXsADjEOdlZ3YiKrCkRrx58YtFi1M6caFsielcQFFg=;
        b=cWi96tVC/Fi7OtiTgxkh8PdS9hP1ImdRopuhzmCUcdYbSvPYsjB/s6JBbAiZl1fqsz
         1pZSpsNmwN9OigcYa5GlPABhQLRYHDOwPFjITII7eNFaWAVWCOsISngUhs8UZV2xgiwy
         xAdIhaqMwgIIR1WorOeyP7LhQH8DiVpGUrrYwfG7fbMxX9noeHEppcXi0pypdkGQ02dh
         VTD8+33vktNesQI7On+L+u7tuFK2RjXLvwyvKHmRu/0bGA+MgGbuGNak1nqhKiXAG1AL
         noNA6EEH4ADiI5uKpi6+ByKYUYENovHMbXv5P/NtOJgTwVhSyU+zFa7jb/annOxfUqgr
         qGmw==
X-Gm-Message-State: APjAAAVIJuVGMb/pQT2QBU+VGWhH4hwDHhoaCww1VNJ+t02D5doSpYq9
        RSs7fCpRmDgFGnC1VfYVWjq9vA==
X-Google-Smtp-Source: APXvYqwaEGTNQ6pH3nMfuHI18X2jWcofC92bUt5mO8xtMpIu9pyAp5ByFh4AqZ1cix2cCPEzxx9A8w==
X-Received: by 2002:a2e:98c6:: with SMTP id s6mr5237392ljj.235.1574200997652;
        Tue, 19 Nov 2019 14:03:17 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id a11sm10429535ljm.60.2019.11.19.14.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 14:03:17 -0800 (PST)
Date:   Tue, 19 Nov 2019 14:03:01 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com,
        jonathan.lemon@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, rizzo@iet.unipi.it
Subject: Re: [PATCH v2] net-af_xdp: use correct number of channels from
 ethtool
Message-ID: <20191119140301.6ff669e1@cakuba.netronome.com>
In-Reply-To: <20191119001951.92930-1-lrizzo@google.com>
References: <20191119001951.92930-1-lrizzo@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 18 Nov 2019 16:19:51 -0800, Luigi Rizzo wrote:
> Drivers use different fields to report the number of channels, so take
> the maximum of all data channels (rx, tx, combined) when determining the
> size of the xsk map. The current code used only 'combined' which was set
> to 0 in some drivers e.g. mlx4.
> 
> Tested: compiled and run xdpsock -q 3 -r -S on mlx4
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>


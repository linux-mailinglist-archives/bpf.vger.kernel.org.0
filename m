Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218763F030F
	for <lists+bpf@lfdr.de>; Wed, 18 Aug 2021 13:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhHRLzT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 07:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232191AbhHRLzT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Aug 2021 07:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629287683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aF2YAaaZplhykzZP8JKiNx+F3piFPmPM20xDcdTGrrE=;
        b=by7pROyW0/XViGX57IDlbE+OSCvHqT+r8v6Aqa7hCtEygh9buRkfGOTVYrGY9ryK/eUcqD
        sxMyHKTA6PUph9Ju2Jxz8I/KUXt7xa+c/4kxjOxJSC3WwMJ50B1iHFNFye4WerfSnpn9pD
        zsI877ni2GS1wAB4bB2cnHbFCvCs5gE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-AoPnzxooMl-nXB7oIebAPQ-1; Wed, 18 Aug 2021 07:54:42 -0400
X-MC-Unique: AoPnzxooMl-nXB7oIebAPQ-1
Received: by mail-wm1-f70.google.com with SMTP id b3-20020a1c80030000b02902e6a7296cb3so565053wmd.5
        for <bpf@vger.kernel.org>; Wed, 18 Aug 2021 04:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=aF2YAaaZplhykzZP8JKiNx+F3piFPmPM20xDcdTGrrE=;
        b=L6aDSsiVTMg2kLGqbEjQ8zCj/+dOe28wjDnL22mZN1OA71Z8f0QzTHUf5fcTvV+vu1
         T/E0xOGTJz7VtU8HGLwQ0JcA65HzqsFL70/v49xFJggj/T/ECAsDM4EmNR37+SuVLzMI
         NgZn84wWB4OYVbJJrIPk7LcFjrh4QdrqCHnf1ArECfQhJhAz2MjrmBII5HNVMxIiN0if
         VhMH6vPY/uRHi6QAvy7lB6Z7hQmozMMpnI+PuMzCM3PyrOSvCtUg6GXUERU+KqQH7x1k
         eEDdrg4wVVcAYevHvZQG6xrQAKnPUeZk5l0Ig8w4kgFQASySg4r4SKJKL5wIwqTpolYF
         KIVg==
X-Gm-Message-State: AOAM533NonhZaMfuDkhPj71BigsRprLsptEI83jN/lkl1wt/qIHMurgk
        gNTXPe0/vXyVA/8kpjaHiyclK4ZQ28Mn1jB49d5dd4WMnz3QXRAOEr8ahBYb9kfbI7hUpRpDYqW
        UqIaOi1mzsxaA
X-Received: by 2002:adf:d227:: with SMTP id k7mr10062271wrh.285.1629287681693;
        Wed, 18 Aug 2021 04:54:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4Cihy/hZE7IlAomO9N7U5eaYxYs2uFifO8eMnZkuiaHLF8ULquzCUmRu2+HmnlR24dHbuXg==
X-Received: by 2002:adf:d227:: with SMTP id k7mr10062256wrh.285.1629287681579;
        Wed, 18 Aug 2021 04:54:41 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id o8sm2794321wmq.21.2021.08.18.04.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 04:54:41 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        bpf <bpf@vger.kernel.org>, Netdev <netdev@vger.kernel.org>
To:     "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Kishen Maloor <kishen.maloor@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        Alexander Lobakin <alobakin@pm.me>
Subject: AF_XDP finding descriptor room for XDP-hints metadata size
Message-ID: <811eb35f-5c8b-1591-1e68-8856420b4578@redhat.com>
Date:   Wed, 18 Aug 2021 13:54:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


In previous discussions with AF_XDP maintainers (Magnus+Bjørn), I 
understood we have two challenges with metadata and BTF id.

  (1) AF_XDP doesn't know size of metadata area.
  (2) No room in xdp_desc to store the BTF-id.

Below I propose new idea to solve (1) metadata size.

To follow the discussion this is struct xdp_desc:

  /* Rx/Tx descriptor */
  struct xdp_desc {
	__u64 addr;
	__u32 len;
	__u32 options;
  };

One option (that was rejected) was to store the BTF-id in 'options' and
deduct the metadata size from BTF-id, but it was rejected as it blocks
future usages of 'options'.

The proposal by Magnus was to use a single bit in 'options' to say this
descriptor contains metadata described via BTF info. And Bjørn proposed
to store the BTF-id as the last member in metadata, as it would be
accessible via minus-4 byte offset from packet start 'addr'. And again
via BTF-id code can know the size of metadata area.

My idea is that we could store the metadata size in top-bits of 'len'
member when we have set the 'options' bit for BTF-metadata.

-Jesper


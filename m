Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD5D51E86
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 00:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfFXWqD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 18:46:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35695 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfFXWqD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 18:46:03 -0400
Received: by mail-qk1-f195.google.com with SMTP id l128so11092425qke.2
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 15:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=l+t11w+lYzgMdf9afpAfNi/wBZxJpJdB0Y+rhM6lHks=;
        b=1JNiS8o8LLcLGJ7yDeuoGqe7R53WxwUnBJ473OA/Sj94hjFkUtbMZgxLmpjtFcBKa6
         N8tfCq4i4n89X7x24u4RaZsPtxHqdSZxpQvXnuae5hnCD5wud1xsEgxlwfhTEoVI9cPt
         g3jQIXuW7CiLlgUVdgWO8zSkn1nQjlMb25O4W634mUf1mJezM/d1gtgwSbKc319j57bs
         dLGovYfEKNj36SFTmOEAS+n8b5B1My2OgGKfdHQcGOBv6EgC/AuW1Oqplc0bR0zzeUgo
         jYXXxiIhD1iH9bA0rFt9Qmmx+ThDGH8ng7MqzQSE2+OlYR7eeju/cBxmDLZn9ZaILbBX
         PPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=l+t11w+lYzgMdf9afpAfNi/wBZxJpJdB0Y+rhM6lHks=;
        b=TlMxnQ3ogUffzTas8ieCITVPbl1JeM7Cxla5zBwluZMRi284dm7sPUeC4OA6uoMcsq
         TnR8bVrV7AOWebaJi3lTROxUmvbhV7Ah15QZ4Ox5kG4wAMNtJ+Kr8LdD4N5ysFwU4AWx
         d2pHMTQiqI4r+GWA+HibkodmOYLSAiqbclSfo6df7dRZ4a+9Bh/rxkuzxQ6aRMDcbFDO
         bqkpBfmUo1aa6m7aKR+WlegwCszn9Hcppt3qk20WdtM5Y/MVMYRtjCjph5MR0c6PL1vR
         2eG5eRhOVOqKQGgrbhaSNqID6206epqk8IucySuvbJ9yqPJcBfLTHcUKZOwi5RyoDyWa
         JPuA==
X-Gm-Message-State: APjAAAWaQfTNPP7v5d0AKI/s5piygY5+xiE8qh3eUiuOSKCVyTQ55ANP
        lRpnSDtabYKnIGi7qZHCIDpPdw==
X-Google-Smtp-Source: APXvYqx2gLjuzKn7dYRM+5cj5gK6T/0dtP3tloIyQ3TQPgnYyzTA7/groXjMvqklxlRwTCwpzetNWQ==
X-Received: by 2002:ae9:e608:: with SMTP id z8mr114743476qkf.182.1561416362271;
        Mon, 24 Jun 2019 15:46:02 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id k40sm7384209qta.50.2019.06.24.15.46.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 15:46:02 -0700 (PDT)
Date:   Mon, 24 Jun 2019 15:45:58 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Brian Vazquez <brianvv@google.com>
Cc:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 2/6] bpf: add BPF_MAP_DUMP command to access more
 than one entry per call
Message-ID: <20190624154558.65c31561@cakuba.netronome.com>
In-Reply-To: <20190621231650.32073-3-brianvv@google.com>
References: <20190621231650.32073-1-brianvv@google.com>
        <20190621231650.32073-3-brianvv@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 21 Jun 2019 16:16:46 -0700, Brian Vazquez wrote:
> @@ -385,6 +386,14 @@ union bpf_attr {
>  		__u64		flags;
>  	};
>  
> +	struct { /* struct used by BPF_MAP_DUMP command */
> +		__u32		map_fd;

There is a hole here, perhaps flags don't have to be 64 bit?

> +		__aligned_u64	prev_key;
> +		__aligned_u64	buf;
> +		__aligned_u64	buf_len; /* input/output: len of buf */
> +		__u64		flags;
> +	} dump;
> +
>  	struct { /* anonymous struct used by BPF_PROG_LOAD command */
>  		__u32		prog_type;	/* one of enum bpf_prog_type */
>  		__u32		insn_cnt;

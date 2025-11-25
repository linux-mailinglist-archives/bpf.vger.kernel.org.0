Return-Path: <bpf+bounces-75415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEF0C82F42
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 01:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C45114E750D
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 00:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF1B21CFE0;
	Tue, 25 Nov 2025 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8cTJCEF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+nK2vCy"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13B1DF985
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 00:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764031603; cv=none; b=PMzdMzniryuDbw8uyXNbxxUyn8lLdo5FISHfSiFXo+Jqd6PVtIH8X8f++KLPwbw8BqgyGbwzYAkLcew6HRJNvO1pbJNr9pJPxAmyIEDIAXKNE9kM7q3NrH8T+HPIkxgSTV8bUQ7qj5Kybcjnot+RFfJN7SWGHfoX2VIolqJYUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764031603; c=relaxed/simple;
	bh=pnrl98pANeFRRT4olQ42d6NG6Yzwq+czl0kMIqqxVJs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rxmH9zkHn258VlMGLoQjAZSL24FiNwIYumDSTKwQnMfG8PgBO5OyspjCwZh3ptxohfeieH1mHX3GK54dIqEALSTwPP5heQ0qZYsgCptXd8pPF3ZMp5PXizRBrMggR+2RQu6XQ3564+YWiEg4tYnIJhQoK18a9Wq9X4nUekDFKCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8cTJCEF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+nK2vCy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764031600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQNtnWOsotCA1HNvoVlP0i2b01R7aawce9e6oJOL594=;
	b=A8cTJCEF7wPka0KUPmYq2StxmoUA5Syh7IbDQQmPTCYIFQnf4G5MCUeyPNT4HTEODKRvTF
	Bt9/JTPSYo87BHcogFqqWkm5cXon0cBOEPEiCyPtfQsI+jdZv19I5rPa2hk/M+PE4ZAnYv
	/YorfigCXDBQqBwCN5xPk1KjyXy/xL4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-_xSeAx_TN8e1IhoUsRPVyw-1; Mon, 24 Nov 2025 19:46:38 -0500
X-MC-Unique: _xSeAx_TN8e1IhoUsRPVyw-1
X-Mimecast-MFC-AGG-ID: _xSeAx_TN8e1IhoUsRPVyw_1764031598
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8826fb20ef0so149024456d6.0
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764031598; x=1764636398; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQNtnWOsotCA1HNvoVlP0i2b01R7aawce9e6oJOL594=;
        b=a+nK2vCyRx89fcfBJxm3DXE4nmpB/xBnlB2kF2DdIJNi5iQoE7g+w1h5ZipF9cGZO8
         THkpUlObS5pRio01gJ3xgpnGMrFLxKdUxfz+BARDlupGubZHl7tySxMNT7X0MMEI2y/L
         eGpaYwoSB1QcDiMfmi5nhvMqRjfQlYfZ/tSbJ2xHTMLIA7aG4CveNLJg4Abc3FUM9pv6
         hoCdC0PpDvY+GOOUqqnzLFQHnz06SE56A+tnnyFFmAdL6GnhZMMrlSF2iCN/1Y9ClOxV
         L1PieInof0/WigDBpLux7KFM7tDmQbsNPmyNs4Hpie9tlxeZj+7G+L6v9ICD2cPxxHxC
         2LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764031598; x=1764636398;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQNtnWOsotCA1HNvoVlP0i2b01R7aawce9e6oJOL594=;
        b=IOXmiJ+Xezuk92MLxe3Kfj57eOvTM4Ip49fhq5VsN6EDncCUSLZxAHh9OP7Ljpszfw
         hWi25vdNcGdfcTwbK2zxyfvcQWvlN+HXHtNO0Zmi2zk056qcrf4Ct91tyFeA27zmHvxu
         4RbZWylcGE7wSk2uGZg4Qz2a/ve/lMRBY97MjndPin3093betk8QR16sOfq3Asr1569P
         cVHwoIapKVomClFqM8i9JiqMwa6SzeHyxaac2R+CQbkNw8gEuDcvvYTH7K3TDVb89Dxz
         Wm84MEsZR+qhMFs47o/n37Vob02PW2KtWtR7jHo1YuvQ2QaiZwJSrvuDLQpzh/yZLGXj
         aRuw==
X-Forwarded-Encrypted: i=1; AJvYcCWg1+VY9fthUpTzQ3x6r2Prnq7ZR/VhD9DSGknF1nDiyBr/AMeJwQW6RtjHnZmHjQdJ7eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDG3u2csZSoLNh1d75bl8X81Ecw69r/Tu3KNPF0SSK2ZDlVsBi
	25yhb+K7w7fsWHZNvlr4WqBb7+9zKJ2ktXBKBvs4x7tcFtxfftkszL/D3QmR0MhK4vPcGF9b0Oo
	ChVgoHvaKyiNvGcN1A5eeqQ2i3r8ZRNMA/FtyWdInJHBTn+BecNjzUA==
X-Gm-Gg: ASbGncu86bGG4Ndtf7ZZnvlkq2iC7W95dhUltvNzlJ+i1qd4X+TmzvnoyOZq+FW6h8d
	SGJM2qbAB+KpvNTT+U1M0vqrHlPNrxWTHzripe9Dre1mjLER026AjOMZRxwdLLWPwMKmtDc2XEu
	s0wlRy7JeB3+nNnHxLgbhHWvDppvoQV/ACFq2GGVnllCUB5sLER6lefF/cRvLLaObtw/PdZwaUQ
	ug4p0RTtQAbcoGaiK/c0LZLeHvyQuo86WNO4RjCtyOhDQH8qXn6P4Dn7l6CeB1rbe4kuB2PJrJE
	qRt3kCEbDY7sJkEIrwBGvwaS12eZ3lezuNQTPrETEoaTHlpEYv1E7mmjxsjvqaVFLCfXUZiUwta
	hC3X3RVByC0eTxKkrpXqjPYKXNgUsnNDy4XoSEPu57A==
X-Received: by 2002:a05:6214:4a09:b0:882:4901:e960 with SMTP id 6a1803df08f44-8847c4c8123mr198048856d6.29.1764031597828;
        Mon, 24 Nov 2025 16:46:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB5+f1yDnZK7hRMic4Sah4dDpUUJqEdE7scW0eh7drx/bT1c7yAK2y5dCpUKma/dEfKV08tw==
X-Received: by 2002:a05:6214:4a09:b0:882:4901:e960 with SMTP id 6a1803df08f44-8847c4c8123mr198048636d6.29.1764031597486;
        Mon, 24 Nov 2025 16:46:37 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54e94csm110992156d6.34.2025.11.24.16.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 16:46:37 -0800 (PST)
Message-ID: <fb5b468b38ac9570a5f3fb948452d1b5b03c9f9c.camel@redhat.com>
Subject: Re: [rtla 07/13] rtla: Introduce timerlat_restart() helper
From: Crystal Wood <crwood@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, Ivan Pravdin	
 <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, Costa
 Shulyupin	 <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 "open list:Real-time Linux Analysis (RTLA) tools"	
 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  "open list:BPF
 [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)"	 <bpf@vger.kernel.org>
Date: Mon, 24 Nov 2025 18:46:36 -0600
In-Reply-To: <20251117184409.42831-8-wander@redhat.com>
References: <20251117184409.42831-1-wander@redhat.com>
	 <20251117184409.42831-8-wander@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:

> +enum restart_result
> +timerlat_restart(const struct osnoise_tool *tool, struct timerlat_params=
 *params)
> +{
> +	actions_perform(&params->common.threshold_actions);
> +
> +	if (!params->common.threshold_actions.continue_flag)
> +		/* continue flag not set, break */
> +		return RESTART_STOP;
> +
> +	/* continue action reached, re-enable tracing */
> +	if (tool->record && trace_instance_start(&tool->record->trace))
> +		goto err;
> +	if (tool->aa && trace_instance_start(&tool->aa->trace))
> +		goto err;
> +	return RESTART_OK;
> +
> +err:
> +	err_msg("Error restarting trace\n");
> +	return RESTART_ERROR;
> +}

The non-BPF functions in common.c have the same logic and should also
call this.  This isn't timerlat-specific.


> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/=
src/timerlat_hist.c
> index 09a3da3f58630..f14fc56c5b4a5 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -1165,18 +1165,19 @@ static int timerlat_hist_bpf_main_loop(struct osn=
oise_tool *tool)
> =20
>  		if (!stop_tracing) {
>  			/* Threshold overflow, perform actions on threshold */
> -			actions_perform(&params->common.threshold_actions);
> +			enum restart_result result;
> =20
> -			if (!params->common.threshold_actions.continue_flag)
> -				/* continue flag not set, break */
> +			result =3D timerlat_restart(tool, params);
> +			if (result =3D=3D RESTART_STOP)
>  				break;
> =20
> -			/* continue action reached, re-enable tracing */
> -			if (tool->record)
> -				trace_instance_start(&tool->record->trace);
> -			if (tool->aa)
> -				trace_instance_start(&tool->aa->trace);
> -			timerlat_bpf_restart_tracing();
> +			if (result =3D=3D RESTART_ERROR)
> +				return -1;

Does it matter that we're not detaching on an error here?  Is this
something that gets cleaned up automatically (and if so, why do we ever
need to do it explicitly)?

> +
> +			if (timerlat_bpf_restart_tracing()) {
> +				err_msg("Error restarting BPF trace\n");
> +				return -1;
> +			}

[insert rant about not being able to use exceptions in userspace code in
the year 2025]

-Crystal



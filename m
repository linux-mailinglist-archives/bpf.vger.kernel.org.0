Return-Path: <bpf+bounces-34748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5D993082E
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 02:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9841C21374
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 00:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF99139E;
	Sun, 14 Jul 2024 00:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBn0rtUc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890C632
	for <bpf@vger.kernel.org>; Sun, 14 Jul 2024 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720916310; cv=none; b=DzArnPL2+pBC83c6J6IjYRC1KeizhwvGXfSGQuzQtvUV6prUOfeK9kou1F+oFgKyfhuf+nWOxXFJ/X1UwK1lOIudH0sDxTVuYxyPaSN9DVFW6UBrttoiQ93+oid64ctQPzlytjvoveGW9SPU/fs+dFwxH7tY2PHceADtlRWuJeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720916310; c=relaxed/simple;
	bh=A0MbmaqRuykH12H1GZozd5fDHvmJCxuBDaybocfGrRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oioZdudYmWJ5vTBbEuYCilNKmaBhsdo18JTgaYYltuskD7SFN8KTIq2MbXMWzgNmxQKljgl4CQMvbipltfIuEqCCCIWgoQb7OKigKU5awWu9Y4z4dzoebRlvW4HZJYdW/kgxRrk/xYj/s1ayzJLy3eLRjUL5cVVh3m46M7eQ5jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBn0rtUc; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-703631c4930so1615225a34.1
        for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 17:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720916307; x=1721521107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/DF7J++gGaU2tuPktK/pRSUksYzpqXP5U37yALuBCk=;
        b=jBn0rtUcI8xR7tTCUitUldjMZfeV7Y4ibCmiTUNDAlili6klgM1a0j+5UpUlXYIc88
         2Fhc2cfgPjUwMGFgKdnBuM8JXpb5a/qSLDilmIE0PdNaCYYmELjGCcKkhyar51omcON5
         G/CDNYjz0re4bTSmnn6L1p2HS438AiMrQ4Z5zd/uHlXkDCu4GPc8qZJbh9YL7EzCOS0A
         5L+JzwB79nNgUv1vFUhd9yZQLiygCeQDYfZ3s32YC4xiEEujBIrxQCsdcuAVPQQAo/qg
         8ahJ/tr1+TNUWJY4kIpyIrCh/7aZgz/z8aLL+xhIZ/4nWUNHRlQpKUmAzA/8MhopfGvz
         +gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720916307; x=1721521107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/DF7J++gGaU2tuPktK/pRSUksYzpqXP5U37yALuBCk=;
        b=S4RPSaMbwi2RlzWKrcIijfLGRd4uQ67zL2ZOtVyI+wxR7pBAnmGht2T6BMKFelnNtS
         5nkfEpqvidlkj0lOsUtSMETryveURLZpXELRAveyj2IdkmMdJ3WQvCzTrNiqw9+93Zmb
         BBEmKuLr9X/2yNtmTXMFz67G53GfAJE44ZcRaZQCM+oFBfj0U5D8qzdjihxTPe5PlgFt
         z+GjGGMsoRr20zPYm4G1t8fGzrfyw4BYivPYvT3L9j4ViAHgyb6oybfyys9Y10GUZtTo
         4jppqGu5PEXnC+OLHmYDdYth7ikAommhCruCRYQuuJvg7JLBh4JgbFHNaYxoUBTbDzZk
         RqKw==
X-Forwarded-Encrypted: i=1; AJvYcCVPJJywPWKZlWaHtAGkAv69zP7a4tMPPVJDVdov2YO7F6nJ8+aYfcnQHK5/sIrr1YJmNezX49ddwGhVsWdFYycH/6PF
X-Gm-Message-State: AOJu0YzSrWwa+vwzF0RlAFpm9QABKEWqvdaBUOe/njIidkbrB8H5aGii
	ovEmFFCn8yvDeYt7OwizTBSvsCY/8Zha2As+58+41XYNvJOTo1oX
X-Google-Smtp-Source: AGHT+IEsq0cl3Vzwdk01mj+SJIHrRZCeFj1qzdA6cwiTlpZoUN7KdqMGfKBJqdJBIEC+NWsFqzuxjA==
X-Received: by 2002:a9d:480a:0:b0:708:455a:8f03 with SMTP id 46e09a7af769-708455a8f27mr10196277a34.34.1720916307360;
        Sat, 13 Jul 2024 17:18:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:23e7:2c91:40d9:5cd0? ([2600:1700:6cf8:1240:23e7:2c91:40d9:5cd0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-65fc4452041sm3177437b3.121.2024.07.13.17.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 17:18:26 -0700 (PDT)
Message-ID: <77492194-0e96-4c27-8a30-39de1f5aa8b3@gmail.com>
Date: Sat, 13 Jul 2024 17:18:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Add traffic monitor
 functions.
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240713055552.2482367-1-thinker.li@gmail.com>
 <20240713055552.2482367-2-thinker.li@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240713055552.2482367-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/12/24 22:55, Kui-Feng Lee wrote:
> Add functions that run tcpdump in the background, report the traffic log
> captured by tcpdump, and stop tcpdump. They are supposed to be used for
> debugging flaky network test cases. A monitored test case should call
> traffic_monitor_start() to start a tcpdump process in the background for a
> given namespace, call traffic_monitor_report() to print the log from
> tcpdump, and call traffic_monitor_stop() to shutdown the tcpdump process.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 244 ++++++++++++++++++
>   tools/testing/selftests/bpf/network_helpers.h |   5 +
>   2 files changed, 249 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 44c2c8fa542a..cf0e03f3b95c 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -12,6 +12,8 @@
>   #include <sys/mount.h>
>   #include <sys/stat.h>
>   #include <sys/un.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
>   
>   #include <linux/err.h>
>   #include <linux/in.h>
> @@ -575,6 +577,248 @@ int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
>   	return 0;
>   }
>   
> +struct tmonitor_ctx {
> +	pid_t pid;
> +	const char *netns;
> +	char log_name[PATH_MAX];
> +};
> +
> +/* Make sure that tcpdump has handled all previous packets.
> + *
> + * Send one or more UDP packets to the loopback interface. The packet
> + * contains a mark string. The mark is used to check if tcpdump has handled
> + * the packet. The function waits for tcpdump to print a message for the
> + * packet containing the mark (by checking the payload length and the
> + * destination). This is not a perfect solution, but it should be enough
> + * for testing purposes.
> + *
> + * log_name is the file name where tcpdump writes its output.
> + * mark is the string that is sent in the UDP packet.
> + * repeat specifies if the function should send multiple packets.
> + *
> + * Device "lo" should be up in the namespace for this to work.  This
> + * function should be called in the same network namespace as a
> + * tmonitor_ctx created for in order to create a socket for sending mark
> + * packets.
> + */
> +static int traffic_monitor_sync(const char *log_name, const char *mark,
> +				bool repeat)
> +{
> +	const int max_loop = 1000; /* 10s */
> +	char mark_pkt_pattern[64];
> +	struct sockaddr_in addr;
> +	int sock, log_fd, rd_pos = 0;
> +	int pattern_size;
> +	struct stat st;
> +	char buf[4096];
> +	int send_cnt = repeat ? max_loop : 1;
> +	bool found;
> +	int i, n;
> +
> +	sock = socket(AF_INET, SOCK_DGRAM, 0);
> +	if (sock < 0) {
> +		log_err("Failed to create socket");
> +		return -1;
> +	}
> +
> +	/* Check only the destination and the payload length */
> +	pattern_size = snprintf(mark_pkt_pattern, sizeof(mark_pkt_pattern),
> +				" > 127.0.0.241.4321: UDP, length %ld",
> +				strlen(mark));
> +
> +	addr.sin_family = AF_INET;
> +	addr.sin_addr.s_addr = inet_addr("127.0.0.241");
> +	addr.sin_port = htons(4321);
> +
> +	/* Wait for the log file to be created */
> +	for (i = 0; i < max_loop; i++) {
> +		log_fd = open(log_name, O_RDONLY);
> +		if (log_fd >= 0) {
> +			fstat(log_fd, &st);
> +			rd_pos = st.st_size;
> +			break;
> +		}
> +		usleep(10000);
> +	}
> +	/* Wait for the mark packet */
> +	for (found = false; i < max_loop && !found; i++) {
> +		if (send_cnt-- > 0) {
> +			/* Send an UDP packet */
> +			if (sendto(sock, mark, strlen(mark), 0,
> +				   (struct sockaddr *)&addr,
> +				   sizeof(addr)) != strlen(mark))
> +				log_err("Failed to sendto");
> +		}
> +
> +		usleep(10000);
> +		fstat(log_fd, &st);
> +		/* Check the content of the log file */
> +		while (rd_pos + pattern_size <= st.st_size) {
> +			lseek(log_fd, rd_pos, SEEK_SET);
> +			n = read(log_fd, buf, sizeof(buf) - 1);
> +			if (n < pattern_size)
> +				break;
> +			buf[n] = 0;
> +			if (strstr(buf, mark_pkt_pattern)) {
> +				found = true;
> +				break;
> +			}
> +			rd_pos += n - pattern_size + 1;
> +		}
> +	}
> +
> +	close(log_fd);
> +	close(sock);
> +
> +	if (!found) {
> +		log_err("Waited too long for synchronizing traffic monitor");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Start a tcpdump process to monitor traffic.
> + *
> + * netns specifies what network namespace you want to monitor. It will
> + * monitor the current namespace if netns is NULL.
> + */
> +struct tmonitor_ctx *traffic_monitor_start(const char *netns)
> +{
> +	struct tmonitor_ctx *ctx = NULL;
> +	struct nstoken *nstoken = NULL;
> +	char log_name[PATH_MAX];
> +	int status, log_fd;
> +	pid_t pid;
> +
> +	if (netns) {
> +		nstoken = open_netns(netns);
> +		if (!nstoken)
> +			return NULL;
> +	}
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		log_err("Failed to fork");
> +		goto error;
> +	}
> +
> +	if (pid == 0) {
> +		/* Child */
> +		pid = getpid();
> +		snprintf(log_name, sizeof(log_name), "/tmp/tmon_tcpdump_%d.log", pid);
> +		log_fd = open(log_name, O_WRONLY | O_CREAT | O_TRUNC, 0644);
> +		dup2(log_fd, STDOUT_FILENO);
> +		dup2(log_fd, STDERR_FILENO);
> +		if (log_fd != STDOUT_FILENO && log_fd != STDERR_FILENO)
> +			close(log_fd);
> +
> +		/* -n don't convert addresses to hostnames.
> +		 *
> +		 * --immediate-mode handle captured packets immediately.
> +		 *
> +		 * -l print messages with line buffer. With this option,
> +		 * the output will be written at the end of each line
> +		 * rather than when the output buffer is full. This is
> +		 * needed to sync with tcpdump efficiently.
> +		 */
> +		execlp("tcpdump", "tcpdump", "-i", "any", "-n", "--immediate-mode", "-l", NULL);
> +		log_err("Failed to exec tcpdump");
> +		exit(1);
> +	}
> +
> +	ctx = malloc(sizeof(*ctx));
> +	if (!ctx) {
> +		log_err("Failed to malloc ctx");
> +		goto error;
> +	}
> +
> +	ctx->pid = pid;
> +	ctx->netns = netns;
> +	snprintf(ctx->log_name, sizeof(ctx->log_name), "/tmp/tmon_tcpdump_%d.log", pid);
> +
> +	/* Wait for tcpdump to be ready */
> +	if (traffic_monitor_sync(ctx->log_name, "hello", true)) {
> +		status = 0;
> +		if (waitpid(pid, &status, WNOHANG) >= 0 &&
> +		    !WIFEXITED(status) && !WIFSIGNALED(status))
> +			log_err("Wait too long for tcpdump");
> +		else
> +			log_err("Fail to start tcpdump");
> +		goto error;
> +	}
> +
> +	close_netns(nstoken);
> +
> +	return ctx;
> +
> +error:
> +	close_netns(nstoken);
> +	if (pid > 0) {
> +		kill(pid, SIGTERM);
> +		waitpid(pid, NULL, 0);
> +		snprintf(log_name, sizeof(log_name), "/tmp/tmon_tcpdump_%d.log", pid);
> +		unlink(log_name);
> +	}
> +	free(ctx);
> +
> +	return NULL;
> +}
> +
> +void traffic_monitor_stop(struct tmonitor_ctx *ctx)
> +{
> +	if (!ctx)
> +		return;
> +	kill(ctx->pid, SIGTERM);
> +	/* Wait the tcpdump process in case that the log file is created
> +	 * after this line.
> +	 */
> +	waitpid(ctx->pid, NULL, 0);
> +	unlink(ctx->log_name);
> +	free(ctx);
> +}
> +
> +/* Report the traffic monitored by tcpdump.
> + *
> + * The function reads the log file created by tcpdump and writes the
> + * content to stderr.
> + */
> +void traffic_monitor_report(struct tmonitor_ctx *ctx)
> +{
> +	struct nstoken *nstoken = NULL;
> +	char buf[4096];
> +	int log_fd, n;

log_fd should be initialized. I will fix it in the next version.

> +
> +	if (!ctx)
> +		return;
> +
> +	/* Make sure all previous packets have been handled by
> +	 * tcpdump.
> +	 */
> +	if (ctx->netns) {
> +		nstoken = open_netns(ctx->netns);
> +		if (!nstoken) {
> +			log_err("Failed to open netns: %s", ctx->netns);
> +			goto out;
> +		}
> +	}
> +	traffic_monitor_sync(ctx->log_name, "sync for report", false);
> +	close_netns(nstoken);
> +
> +	/* Read the log file and write to stderr */
> +	log_fd = open(ctx->log_name, O_RDONLY);
> +	if (log_fd < 0) {
> +		log_err("Failed to open log file");
> +		return;
> +	}
> +
> +	while ((n = read(log_fd, buf, sizeof(buf))) > 0)
> +		fwrite(buf, n, 1, stderr);
> +
> +out:
> +	close(log_fd);
> +}
> +
>   struct send_recv_arg {
>   	int		fd;
>   	uint32_t	bytes;
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index 9ea36524b9db..d757e495fb39 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -72,6 +72,11 @@ int get_socket_local_port(int sock_fd);
>   int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
>   int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
>   
> +struct tmonitor_ctx;
> +struct tmonitor_ctx *traffic_monitor_start(const char *netns);
> +void traffic_monitor_stop(struct tmonitor_ctx *ctx);
> +void traffic_monitor_report(struct tmonitor_ctx *ctx);
> +
>   struct nstoken;
>   /**
>    * open_netns() - Switch to specified network namespace by name.


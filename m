Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF8A477ED4
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 22:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbhLPVaH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 16:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbhLPVaH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 16:30:07 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B64C061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 13:30:06 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id z206so336697wmc.1
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 13:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=IL78GSdb5NfBt4jK7QBxmwE+dG3VPFYbtbjroH5/cDk=;
        b=Sd4kgtYJAGvKO9KqsAjkKWnKguYDCJj3ESSJtQsSvzsx1MBur78GQmNsBea0Ynh3N5
         jYEauh0mI93j6JsJOViZIOEWE7+F7ayCCL2upwcATG+NdOKe6AHx4PilH3k3vDA08x38
         7ThEpT2jtAO2d8w7+fHw0sm4aM4rarSc+C5NXDVh7QbuAR8ViCTXtNdYqfXKkJAc9fII
         /sUURX5FDaqohEGvmZ4bD/l/T0Bk0eZKGQXHepmCJ/1abuFTJ+FjPwdmjhPYClY1Wrkh
         ZCcnSXiRf03vdrB313qDVooZEauUc7uF6Wlm+IrIJI3kcXFxsOrjX4T4yOmKSM74wbL1
         Yg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IL78GSdb5NfBt4jK7QBxmwE+dG3VPFYbtbjroH5/cDk=;
        b=d6ymzobWLs1Equ3l1qBDR17iWGbWiJ3WSbC5J4UhIuS7zWPXXW8JOpViD3XhNXjN6l
         cRxkS5JkDHK9tb4jDXBZPjSPMswd9RTgsMsHnFarzBFQuixglSDtpCp29xtSDKSIs5YU
         4cC08Si3F1HvCcyrWXqp6naGPNqgcTZcW0OMMjt/5hvu1Kfx67yAFSpjXNzQnEFu12/A
         MRC0dckYy4D24RG3AAXVy2NpWX1qyjh/85aP1Stwiujf3qifZd6z2LH/c01exX1tngKW
         IFCtnZ1mIMfVNNRzV8sVF1Cvq85fM1BWNww5kE0tmQRayEm/VNq6m5yfEQ8h4df/d/ae
         C/lA==
X-Gm-Message-State: AOAM531LuZTHjnat5na3+BsPciDEGKsdL4i0RsPMnWXt+h0mositJ90v
        1ANkTXNuIaricGOV/gJA74yK
X-Google-Smtp-Source: ABdhPJwEd2rGtR4XOFkkzpmH/XCvEa/lvo5d+sXdzF0at4ZLGaUTLH82JOtEoKrYSVY0UnewZaWCeA==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr1567414wml.119.1639690205162;
        Thu, 16 Dec 2021 13:30:05 -0800 (PST)
Received: from Mem (2a01cb088160fc00945483c765112a48.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:9454:83c7:6511:2a48])
        by smtp.gmail.com with ESMTPSA id u14sm6054241wrf.39.2021.12.16.13.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:30:04 -0800 (PST)
Date:   Thu, 16 Dec 2021 22:30:03 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf] bpftool: Flush tracelog output
Message-ID: <CAHMuVOC1bwuY_X5doyWEZfw2yTb=cB-J5dYK2SnDGzD0=fAbew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The output of bpftool prog tracelog is currently buffered, which is
inconvenient when piping the output into other commands. A simple
tracelog | grep will typically not display anything. This patch fixes it
by flushing the tracelog output after each line from the trace_pipe file.

Fixes: 30da46b5dc3a ("tools: bpftool: add a command to dump the trace pipe")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Paul Chaignon <paul@isovalent.com>
---
 tools/bpf/bpftool/tracelog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/tracelog.c b/tools/bpf/bpftool/tracelog.c
index e80a5c79b38f..b310229abb07 100644
--- a/tools/bpf/bpftool/tracelog.c
+++ b/tools/bpf/bpftool/tracelog.c
@@ -158,6 +158,7 @@ int do_tracelog(int argc, char **argv)
                        jsonw_string(json_wtr, buff);
                else
                        printf("%s", buff);
+               fflush(stdout);
        }

        fclose(trace_pipe_fd);
--
2.25.1

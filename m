Return-Path: <bpf+bounces-16039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C477FB92E
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 12:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E88C282CE5
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365964F5EB;
	Tue, 28 Nov 2023 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="qTudIV55"
X-Original-To: bpf@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2067.outbound.protection.outlook.com [40.92.99.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE1D6;
	Tue, 28 Nov 2023 03:15:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmdjhCkZlzJtNFLNr41XaSCfyFC+al8aGLCaNg7YHBRHOTufFOSs89IkGxiFWHa0Jmpmijkqy7iUwbTSSfxmorQSo2Q7kgE7da9kvyVzM+wpQ5vdd58HnN3GD7xfrojSrJBFyfc19HwmfMf50/tfKrMQsZKV5eNNqnKa1ZIxKb6cq4QpBOUIjZnN/ddeNAbbF5vS1IyNcU4ra7g+L8uyKHrUVWAWe4WP0OSt33HMpJnVPnq240dNxHLSjRBnzYzCd44Mj/mYyS6TBC6LNp3ugY40zpveXiEuW89EbbcALysRT9T2iHSloDbLpnFehKKCtOhiqFaDt38hFHeggz+o2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=UM+KarxPDwtWU5CdX8Ji4Gpq1dGZtR+6dx6qGNRCRf0vOerjj8BZ7K0LbJb0keEZjUowLcX7uNqWnv3J/I6+rwFoXioDRVkp3ejs4g43sxelefvgTaLZ5zbPpvaf5VU341wE4v+aOlIoCw976y0uKy/zdZFvSlIFuqAR1CemcqwII9pxrl+7pgL1GIGOLGpRCIY6kfy9FQ6oFU0sXUNS6wc/Lv8U0c9HStA5ethxcklCoEC6E00Uapzz0y/xmYRVeAAkFZ8PfPp793drrwSBdc1OZLJFjKWHiMVPRyzWpW24a8PMzAGLtnpn8sJijCPBbVGG9BYaXOeOqCY1kze01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=qTudIV55S7X+jm+y9VAHDgRjm7HPcs9Y5KxA7k0IuuollpapLl0rBSgbQbSjChjuEemg8iROL7V640s4wCeiDxThnPp34fGBrk+muRoNOPXdApdesPOwwO7B93cxtSZ1uAfd9ekLtPBHsX1ptsYGG3KbBUrK69NQ20Ky++XQXTkqhgm3UFlsW1TLWt6v1kv7h1zahC6FdXkNa+KBpLZMjP7GC7s4pUwPzz9DXqOqN+Uf7D2CactLqzGfSeJ3Ss5wVfnpGS62ZL983Ci0rM0M5W2CyuIIDOBAAZWM6u2gNYVARynq0+p94pJaz8OjwZRLGcrSlsK/OFTyeiY/GrmCCA==
Received: from OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b9::12)
 by TYWP286MB3756.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 11:15:12 +0000
Received: from OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 ([fe80::353:ccff:c96d:6290]) by OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 ([fe80::353:ccff:c96d:6290%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 11:15:12 +0000
From: Anquan Wu <leiqi96@hotmail.com>
To: leiqi96@hotmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] libbpf: fix the name of a reused map
Date: Tue, 28 Nov 2023 19:14:52 +0800
Message-ID:
 <OSZP286MB1725AFE5BEA5E8C515DAA080B8BCA@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [wPry6Xq6/tcJ+u4QxG7HhA1DqCOg7KVM]
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1b9::12)
X-Microsoft-Original-Message-ID:
 <OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
 (raw)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1725:EE_|TYWP286MB3756:EE_
X-MS-Office365-Filtering-Correlation-Id: 662af05a-57d3-4cf4-1d81-08dbf00349b5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nxaHdsW1E3VKUMsT25SnLZHX+158BK6zAXGUzSYETl6+lgDoGB6q2DMKvveU7nKf2fmF7OnuJ/WpqYYpliYuL/Z+b9Mo8zvek5T2A9/MHWyWyasb6ZtKbSetJ+TGf4rWGUlfk0+/tvBTsPCXdgJ8Wkv8wvZqpy4FYHhO0XdE53rxLoPr1qMMN1uEgeEflBoWCzeB9yKR25f9NNKAy2Ds4cGyhfPUOetUx+MYpzCWXsyaV+sOc2aH7rjmnQfHZaUtdiQ6F1lZ1Z2Lg7okHmNQBfqu4up24nqiGIRjs3z0jGLkhHb9xI0owheuZU4vx9CxxXRIXAF1LZUHGV1cONM22BUDA5V1jo79P+nThfgNL14=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1NWZbXFl0E2YQ8jDOL9opRgleRAy5qskMFwU/wWwyZvQUN/6qJ77nuJ5OhJA?=
 =?us-ascii?Q?wZ/tihtrdOkpJp9fQ4G52R9Tzz2FzQ1UrkdSAuK9e16ECjkplRdjDuF8yzNm?=
 =?us-ascii?Q?z42qaU6UjlTpAeZxpX7+BHnMk2P/4GKUXlCaGfeC3VBwP6Pc9e9+UokexJ3x?=
 =?us-ascii?Q?2nKWtX3l1JVLHYWyHQaqrZyh5QePYqP+839OSyVHF4mc+7XtYuyfutGUNj+t?=
 =?us-ascii?Q?If3FsUQbRbHIQ1PD83Xl2/PB9lQEJ/nFZaBzjBDxjEQVGbcLw8i7FQ6isGk+?=
 =?us-ascii?Q?5uNtpD3EKZT2/AWSwmKKwPv8HPUvWzcjRdx1bqMZ8cWGStFE+Md+KTPYJJ+H?=
 =?us-ascii?Q?5Wmsm2/L7iQW6CM6pY69ZFLr4wegThSL89bFY5fTbbx7VkuS9p0UijT0bGqn?=
 =?us-ascii?Q?rYkoq12RZj21Sajx/phrRlzxPkw9rlpPDL6zyvwITAWc9FMKOUL7N+nhF1O4?=
 =?us-ascii?Q?ROKk8Zorn6W7IRGqm/gWn7MhbFjZ1gYGdcgwCv7B/MiN25iG5KCrXapKH/GJ?=
 =?us-ascii?Q?axVFLFd39LSa7RJLh7FXVSXoVTGurDBGPJqJY+p/RU7DcIA/t/qLlu2f1lr7?=
 =?us-ascii?Q?GHO1+mUuv0LkCNDg7hOY1rqejnTyGR/EJNH6WIoLJVjrGuTbtU0Ec/q+JMpB?=
 =?us-ascii?Q?5LiQfNm0CwHYLra222VLgOz5zuBgB5KikNR5sQdL2FS6QkaG12ZcnguuCSt2?=
 =?us-ascii?Q?AEiC4/aa6sfx67iOCD5XuFhHsaE3fjHScgr8dN5SCpqpvDmWawDyUB3AEmsR?=
 =?us-ascii?Q?cHjTECULHcQsLnNJNfkbcSI7o12QXB25uZuEEZe/FDXnBt0x9UztM8eKiWmg?=
 =?us-ascii?Q?xrTyAMpCd7WzVLwxB8C1PuEGojX/XvZLUjDOmxrke0AlpDw5AA4MaEOPB8iV?=
 =?us-ascii?Q?oCd+yyJUI4yXo8kaG+6VihC1gLt+S7GsNdz5Qyyh7ql3P6lkLal39iIiFdyQ?=
 =?us-ascii?Q?nVEZ/oA8wusH33Gm7oXolFiQip1GIxH6xbZTDtX/c4J+BgTLM6UXI8Ne1KyA?=
 =?us-ascii?Q?O1xaBhLtimaj70krYcD3vhd8ksP3I+X+QyavNacwg0/s961js2iWV+CiGR8w?=
 =?us-ascii?Q?yPLTyZZtQ/RpAlCRdiIo+j0V5jddEtC2udMbMKwqWgYMrGX+Shr6S5PROltD?=
 =?us-ascii?Q?NJjA9wv5sgFC4Lzy2YyOh2vKpujVAiOpZwXNkiin1bSrG5rLlinAy/O9zWsf?=
 =?us-ascii?Q?75tOaUUAQ6c3ftm7z5Dtv1Qh0wmnV+Iak5iRtw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 662af05a-57d3-4cf4-1d81-08dbf00349b5
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 11:15:11.9639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3756


